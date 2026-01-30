
//  ContentView.swift


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            Text(" Color Match Memory Game")
                .font(.title)
                .padding()

            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.tiles.indices, id: \.self) { index in
                    TileView(tile: viewModel.tiles[index])
                        .onTapGesture {
                            viewModel.selectTile(index)
                        }
                }
            }
            .padding()
        }
    }
}

