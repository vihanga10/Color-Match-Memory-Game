
//  TileView.swift

import SwiftUI

struct TileView: View {
    let tile: Tile

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.25))
                .shadow(radius: 4)

            if tile.isFlipped || tile.isMatched {
                if tile.isBonus {
                    Image(systemName: "star.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.blue)
                } else if let color = tile.color {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)   
        .animation(.easeInOut(duration: 0.25), value: tile.isFlipped)
    }
}
