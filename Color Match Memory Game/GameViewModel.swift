

//  GameViewModel.swift


import Combine
import SwiftUI

class GameViewModel: ObservableObject {

    @Published var tiles: [Tile] = []
    @Published var score = 0
    @Published var moves = 0
    @Published var secondsElapsed = 0
    

    private var firstSelectedIndex: Int?
    private var difficulty: Difficulty!
    private var timer: Timer?
    var formattedTime: String {
        let minutes = secondsElapsed / 60
        let seconds = secondsElapsed % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // MARK: - GAME RESET
    func resetGame(difficulty: Difficulty) {
        self.difficulty = difficulty

        score = 0
        moves = 0
        secondsElapsed = 0
        firstSelectedIndex = nil

        timer?.invalidate()
        startTimer()

        generateTiles()
    }

    // MARK: - TILE GENERATION (THIS FIXES MISSING TILES)
    private func generateTiles() {
        var tilesArray: [Tile] = []

        // Flatten all colors
        let baseColors = Color.colorFamilies.flatMap { $0 }

        var generatedColors: [Color] = []
        var colorIndex = 0

        // 🔁 Reuse colors safely
        while generatedColors.count < difficulty.pairsCount {
            generatedColors.append(baseColors[colorIndex % baseColors.count])
            colorIndex += 1
        }

        // Create pairs
        for color in generatedColors {
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

        tiles[index].isFlipped = true

        // BONUS TILE → NO FREE POINT
        if tiles[index].isBonus {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.tiles[index].isFlipped = false
            }
            return
        }

        if let firstIndex = firstSelectedIndex {
            moves += 1

            if tiles[firstIndex].color == tiles[index].color {
                tiles[firstIndex].isMatched = true
                tiles[index].isMatched = true
                score += 1

                // 🎯 BONUS POINT ONLY WHEN ALL PAIRS MATCHED
                let matchedPairs = tiles.filter { $0.isMatched }.count / 2
                if matchedPairs == difficulty.pairsCount {
                    score += 1 // bonus
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

    // MARK: - TIMER
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }
}

