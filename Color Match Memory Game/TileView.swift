//
//  TileView.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

import SwiftUI

struct TileView: View {
    let tile: Tile

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .shadow(radius: 4)

            if tile.isFlipped || tile.isMatched {
                if tile.isBonus {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                } else if let color = tile.color {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color)
                }
            }
        }
        .frame(height: 80)
        .animation(.easeInOut, value: tile.isFlipped)
    }
}
