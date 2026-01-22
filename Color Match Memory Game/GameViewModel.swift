
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

    func resetGame(difficulty: Difficulty) {
        score = 0
        moves = 0
        secondsElapsed = 0
        firstSelectedIndex = nil
        timer?.invalidate()

        startTimer()

        let pastelColors = Array(Color.pastelColors.prefix(difficulty.pairsCount))
        var tilesArray: [Tile] = []

        // Create pairs
        for color in pastelColors {
            tilesArray.append(Tile(color: color))
            tilesArray.append(Tile(color: color))
        }

        // Add ONE bonus tile
        tilesArray.append(Tile(color: nil, isBonus: true))

        tilesArray.shuffle()
        tiles = tilesArray
    }

    func selectTile(_ index: Int) {
        guard !tiles[index].isFlipped,
              !tiles[index].isMatched else { return }

        tiles[index].isFlipped = true

        // Bonus tile
        if tiles[index].isBonus {
            score = min(score + 1, 5)
            return
        }

        if let firstIndex = firstSelectedIndex {
            moves += 1

            if tiles[firstIndex].color == tiles[index].color {
                tiles[firstIndex].isMatched = true
                tiles[index].isMatched = true
                score = min(score + 1, 5)

                // Extra point for completing all 4 pairs
                if tiles.filter({ $0.isMatched }).count == 8 {
                    score = min(score + 1, 5)
                }

                firstSelectedIndex = nil
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

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }

    var formattedTime: String {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        return String(format: "%02d.%02d min", minutes, seconds)
    }
}
