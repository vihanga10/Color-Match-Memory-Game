//
//  GameView.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

import SwiftUI

struct GameView: View {
    let difficulty: Difficulty

    @StateObject private var viewModel = GameViewModel()

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: difficulty.gridSize.cols)
    }

    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.resetGame(difficulty: difficulty)
                } label: {
                    Text("Reset")
                        .padding(10)
                        .background(Color.pastelPink)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()

                Text("Score: \(viewModel.score)")
                    .font(.title2)
                    .bold()

                Spacer()

                Button {
                    viewModel.goBack()
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(Color.pastelPurple)
                }
            }
            .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.tiles.indices, id: \.self) { index in
                    TileView(tile: viewModel.tiles[index])
                        .onTapGesture {
                            viewModel.selectTile(index)
                        }
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.resetGame(difficulty: difficulty)
        }
    }
}
