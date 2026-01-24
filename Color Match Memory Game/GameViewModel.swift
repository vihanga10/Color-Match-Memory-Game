
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
    @Published var moves: Int = 0
    @Published var secondsElapsed: Int = 0

    private var firstSelectedIndex: Int?
    private var timer: Timer?
    private var difficulty: Difficulty!

    private var bonusTileOpened = false   // 🔑 KEY FIX

    // MARK: - RESET GAME
    func resetGame(difficulty: Difficulty) {
        self.difficulty = difficulty

        score = 0
        moves = 0
        secondsElapsed = 0
        firstSelectedIndex = nil
        bonusTileOpened = false
        timer?.invalidate()

        startTimer()

        let families = Color.colorFamilies.shuffled()
        var selectedColors: [Color] = []

        // Pick colors for pairs
        for family in families {
            if let color = family.randomElement() {
                selectedColors.append(color)
            }
            if selectedColors.count == difficulty.pairsCount { break }
        }

        var tilesArray: [Tile] = []

        // Create pairs
        for color in selectedColors {
            tilesArray.append(Tile(color: color))
            tilesArray.append(Tile(color: color))
        }

        // Add ONE bonus tile
        tilesArray.append(Tile(color: nil, isBonus: true))

        tilesArray.shuffle()
        tiles = tilesArray
    }

    // MARK: - TILE SELECTION
    func selectTile(_ index: Int) {
        guard !tiles[index].isFlipped,
              !tiles[index].isMatched else { return }

        // 🔵 BONUS TILE (NO FREE POINTS)
        if tiles[index].isBonus {
            bonusTileOpened = true
            tiles[index].isFlipped = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.tiles[index].isFlipped = false
            }
            return
        }

        // 🔹 NORMAL TILE
        tiles[index].isFlipped = true

        if let firstIndex = firstSelectedIndex {
            moves += 1

            if tiles[firstIndex].color == tiles[index].color {
                tiles[firstIndex].isMatched = true
                tiles[index].isMatched = true
                score += 1

                firstSelectedIndex = nil

                checkForCompletionBonus()

            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.tiles[firstIndex].isFlipped = false
                    self.tiles[index].isFlipped = false
                    self.firstSelectedIndex = nil
                }
            }
        } else {
            firstSelectedIndex = index
        }
    }

    // MARK: - COMPLETION BONUS
    private func checkForCompletionBonus() {
        let matchedPairs = tiles.filter { $0.isMatched }.count / 2

        if matchedPairs == difficulty.pairsCount,
           bonusTileOpened,
           score == difficulty.pairsCount {

            score += 1   // 🎯 FINAL BONUS POINT
        }
    }

    // MARK: - TIMER
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }

    var formattedTime: String {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
