

//  GameViewModel.swift

import SwiftUI
import Combine



class GameViewModel: ObservableObject {

    // MARK: - UI STATE
    @Published var tiles: [Tile] = []
    @Published var score = 0
    @Published var moves = 0

    // Timers
    @Published var secondsElapsed = 0       // Level 1
    @Published var timeRemaining = 0         // Level 2

    // Popups
    @Published var showWinPopup = false
    @Published var showResultPopup = false
    @Published var didWinTimeAttack = false

    // Game control
    @Published var stage: GameStage = .normal
    @Published var gameLocked = false   // 🔒 freezes game when time up

    // MARK: - INTERNAL STATE
    private var difficulty: Difficulty!
    private var timer: Timer?
    private var firstSelectedIndex: Int?
    private var level1FinishTime = 0

    // MARK: - TIME FORMAT
    var formattedTime: String {
        let time = stage == .normal ? secondsElapsed : timeRemaining
        return String(format: "%02d:%02d", time / 60, time % 60)
    }

    // MARK: - START / RESET GAME
    func resetGame(difficulty: Difficulty, stage: GameStage = .normal) {
        self.difficulty = difficulty
        self.stage = stage

        score = 0
        moves = 0
        secondsElapsed = 0
        firstSelectedIndex = nil
        gameLocked = false

        timer?.invalidate()

        if stage == .normal {
            startCountUpTimer()
        } else {
            timeRemaining = max(level1FinishTime - 1, 1)
            startCountDownTimer()
        }

        generateTiles()
    }

    // MARK: - TILE GENERATION
    private func generateTiles() {
        var array: [Tile] = []
        let colors = Color.colorFamilies.flatMap { $0 }

        for i in 0..<difficulty.pairsCount {
            let color = colors[i % colors.count]
            array.append(Tile(color: color))
            array.append(Tile(color: color))
        }

        array.append(Tile(color: nil, isBonus: true))
        array.shuffle()
        tiles = array
    }

    // MARK: - TILE SELECTION
    func selectTile(_ index: Int) {
        guard !gameLocked,
              !tiles[index].isFlipped,
              !tiles[index].isMatched else { return }

        tiles[index].isFlipped = true

                // 🎁 BONUS TILE (visual only)
        if tiles[index].isBonus {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.tiles[index].isFlipped = false
            }
            return
        }


        if let first = firstSelectedIndex {
            moves += 1

            if tiles[first].color == tiles[index].color {
                tiles[first].isMatched = true
                tiles[index].isMatched = true

                score += stage == .normal
                    ? difficulty.normalPointsPerPair
                    : difficulty.timeAttackPointsPerPair

                checkWin()
                firstSelectedIndex = nil
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.tiles[first].isFlipped = false
                    self.tiles[index].isFlipped = false
                    self.firstSelectedIndex = nil
                }
            }
        } else {
            firstSelectedIndex = index
        }
    }

    // MARK: - WIN CHECK
    private func checkWin() {
        let matchedPairs = tiles.filter { $0.isMatched }.count / 2

        if matchedPairs == difficulty.pairsCount {
            timer?.invalidate()

            // ✅ ADD BONUS POINTS HERE
            score += stage == .normal
                ? difficulty.normalBonusPoints
                : difficulty.timeAttackBonusPoints

            if stage == .normal {
                level1FinishTime = secondsElapsed
                showWinPopup = true
            } else {
                didWinTimeAttack = true
                showResultPopup = true
            }
        }
    }


    // MARK: - TIMERS
    private func startCountUpTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.secondsElapsed += 1
        }
    }

    private func startCountDownTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.timeRemaining -= 1
            if self.timeRemaining <= 0 {
                self.timer?.invalidate()
                self.gameLocked = true
                self.didWinTimeAttack = false
                self.showResultPopup = true
            }
        }
    }

    // MARK: - RESULT DATA
    func remainingTilesCount() -> Int {
        tiles.filter { !$0.isMatched && !$0.isBonus }.count
    }
    
    
}
