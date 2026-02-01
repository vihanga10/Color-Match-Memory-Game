
//  LeaderboardView.swift

import SwiftUI

struct LeaderboardView: View {
    @StateObject private var manager = LeaderboardManager()
    @State private var selectedDifficulty: Difficulty = .beginner

    var body: some View {
        VStack(spacing: 20) {

            // MARK: - Title
            Text("LEADERBOARD")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 52/255, green: 96/255, blue: 132/255))
                .padding(.top, 20)

            // MARK: - Difficulty Selector
            DifficultySegmentedControl(selected: $selectedDifficulty)
                .padding(.horizontal)

            ScrollView {
                VStack(alignment: .leading, spacing: 30) {

                    // MARK: - Level 1
                    Text("Level 1")
                        .font(.title3)
                        .padding(.leading)

                    Level1Table(
                        entries: manager.entriesFor(
                            difficulty: selectedDifficulty,
                            level: .normal
                        )
                    )

                    // MARK: - Level 2
                    Text("Level 2")
                        .font(.title3)
                        .padding(.leading)

                    Level2Table(
                        entries: manager.entriesFor(
                            difficulty: selectedDifficulty,
                            level: .timeAttack
                        )
                    )
                }
                .padding(.bottom, 40)
            }
        }
        .background(
            LinearGradient(
                colors: [Color.white, Color(red: 230/255, green: 240/255, blue: 247/255)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
