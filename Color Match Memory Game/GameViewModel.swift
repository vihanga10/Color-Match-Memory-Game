
//
//  GameViewModel.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

import SwiftUI
import Combine

class GameViewModel: ObservableObject {

    @Published var tiles: [Tile] = []
    @Published var score: Int = 0

    private var firstSelectedIndex: Int? = nil
    private var difficulty: Difficulty?
    
    func resetGame(difficulty: Difficulty) {
        self.difficulty = difficulty
        score = 0
        firstSelectedIndex = nil

        // Generate tile pairs using pastel colors
        let pastelColors = Color.pastelColors
        let pairsNeeded = difficulty.pairsCount

        var selectedColors = Array(pastelColors.prefix(pairsNeeded))
        selectedColors += selectedColors // duplicate for pairs
        selectedColors.shuffle()

        tiles = selectedColors.map { Tile(color: $0) }
    }

    func selectTile(_ index: Int) {
        guard !tiles[index].isFlipped, !tiles[index].isMatched else { return }

        tiles[index].isFlipped = true

        if let firstIndex = firstSelectedIndex {
            if tiles[firstIndex].color == tiles[index].color {
                tiles[firstIndex].isMatched = true
                tiles[index].isMatched = true
                score += 1
                firstSelectedIndex = nil
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.tiles[firstIndex].isFlipped = false
                    self.tiles[index].isFlipped = false
                    self.firstSelectedIndex = nil
                }
            }
        } else {
            firstSelectedIndex = index
        }
    }

    func goBack() {
        // Navigation handled by NavigationStack, no action needed here
    }
}
