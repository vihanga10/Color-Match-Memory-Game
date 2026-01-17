
//
//  GameViewModel.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var tiles: [Tile] = []
    private var firstSelectedIndex: Int? = nil

    init() {
        setupGame()
    }

    func setupGame() {
        let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink]
        let pairedColors = (colors + colors).shuffled()

        tiles = pairedColors.map { Tile(color: $0) }
    }

    func selectTile(_ index: Int) {
        if tiles[index].isFlipped || tiles[index].isMatched { return }

        tiles[index].isFlipped = true

        if let firstIndex = firstSelectedIndex {
            checkMatch(firstIndex, index)
            firstSelectedIndex = nil
        } else {
            firstSelectedIndex = index
        }
    }

    private func checkMatch(_ first: Int, _ second: Int) {
        if tiles[first].color == tiles[second].color {
            tiles[first].isMatched = true
            tiles[second].isMatched = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tiles[first].isFlipped = false
                self.tiles[second].isFlipped = false
            }
        }
    }
}
