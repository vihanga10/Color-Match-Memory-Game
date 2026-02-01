//  GameView.swift

import SwiftUI




struct GameView: View {

    let difficulty: Difficulty
    let playerName: String
    let playerAge: Int

    @StateObject private var viewModel = GameViewModel()
    @State private var goToDashboard = false
    @State private var stage: GameStage = .normal
    @Environment(\.dismiss) private var dismiss


    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: 14),
            count: difficulty.cols
        )
    }

    var body: some View {
        ZStack {

            LinearGradient(
                colors: [Color.white, Color(red: 183/255, green: 211/255, blue: 228/255)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {

                Text(difficulty.title)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 55/255, green: 100/255, blue: 140/255))

                Text("Hello \(playerName) 👋")
                    .font(.headline)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(viewModel.tiles.indices, id: \.self) { index in
                            TileView(tile: viewModel.tiles[index])
                                .onTapGesture {
                                    viewModel.selectTile(index)
                                }
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                    .padding()
                }

                HStack {
                    statView("TIME", viewModel.formattedTime, .red)
                    statView("MOVES", "\(viewModel.moves)", .black)
                    statView("POINTS", "\(viewModel.score)", .blue)
                }

                Button("RESET") {
                    viewModel.resetGame(difficulty: difficulty, stage: stage)

                }
                .frame(maxWidth: .infinity)
                .frame(height: 45)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal, 30)
            }

            // 🔔 WIN POPUP
            if viewModel.showWinPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                WinPopupView(
                    difficulty: difficulty,
                    score: viewModel.score,
                    time: viewModel.formattedTime,
                    onYes: {
                        viewModel.showWinPopup = false
                        startNextLevel()
                    },
                    onNo: {
                        viewModel.showWinPopup = false
                        goToDashboard = true
                        dismiss()
                    }
                )
            }
            
            // ⏱ TIME ATTACK RESULT POPUP
            if viewModel.showResultPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                TimeAttackResultView(
                    didWin: viewModel.didWinTimeAttack,
                    score: viewModel.score,
                    maxScore: difficulty.timeAttackMaxScore,
                    moves: viewModel.moves,
                    timeUsed: viewModel.timeUsed,
                    tilesRemaining: viewModel.remainingTilesCount(),
                    onYes: {
                            if viewModel.didWinTimeAttack {
                                print("Go to Leaderboard")
                            } else {
                                viewModel.resetGame(difficulty: difficulty, stage: .timeAttack)
                            }
                        },

                        onNo: {
                            goToDashboard = true
                            dismiss()
                        }                )
            }

        }
        .onAppear {
            viewModel.resetGame(difficulty: difficulty, stage: stage)

        }
    }

    // MARK: - Helpers

    private func statView(_ title: String, _ value: String, _ color: Color) -> some View {
        VStack {
            Text(title).font(.headline)
            Text(value).foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
    }

    private func startNextLevel() {
        stage = .timeAttack
            viewModel.resetGame(difficulty: difficulty, stage: .timeAttack)
    }
    
    func saveResultToLeaderboard() {
        let entry = LeaderboardEntry(
            playerName: playerName,
            difficulty: difficulty,
            level: viewModel.stage,
            score: viewModel.score,
            timeSpent: viewModel.stage == .normal ? viewModel.secondsElapsed : viewModel.timeUsed,
            moves: viewModel.moves,
            pairsCompleted: viewModel.stage == .timeAttack ? difficulty.pairsCount - viewModel.remainingTilesCount() : nil,
            tilesRemaining: viewModel.stage == .timeAttack ? viewModel.remainingTilesCount() : nil,
            date: Date()
        )
        // Use a shared instance or create and keep one LeaderboardManager to add entry
        LeaderboardManager().addEntry(entry)
    }

}
