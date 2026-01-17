//
//  ContentView.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

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
            Text("🎨 Color Match Memory Game")
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

struct TileView: View {
    let tile: Tile

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(tile.isFlipped || tile.isMatched ? tile.color : Color.gray)
                .frame(height: 80)
                .animation(.easeInOut, value: tile.isFlipped)
        }
    }
}
