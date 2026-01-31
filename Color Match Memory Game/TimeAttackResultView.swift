
//  TimeAttackResultView.swift

import SwiftUI

struct TimeAttackResultView: View {
    let didWin: Bool
    let score: Int
    let maxScore: Int
    let moves: Int
    let timeUsed: Int
    let tilesRemaining: Int

    let onYes: () -> Void
    let onNo: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(didWin ? "🎉 YOU WON!" : "⏱ TIME UP!")
                .font(.largeTitle)
                .bold()

            Text("Score: \(score) / \(maxScore)")
            Text("Moves: \(moves)")
            Text("Time Used: \(timeUsed)s")

            if !didWin {
                Text("Time spent: \(timeUsed)s")
            } else {
                Text("Tiles Left: \(tilesRemaining)")
                    .foregroundColor(.red)
            }

            Text(didWin ? "Do you want to view leaderboard?" : "Retry Level 2?")
                .font(.headline)

            HStack(spacing: 20) {
                Button("NO") {
                    onNo()
                }
                .frame(width: 120, height: 44)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)

                Button("YES") {
                    onYes()
                }
                .frame(width: 120, height: 44)
                .background(didWin ? Color.blue : Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .frame(width: 320)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
