
//  TimeAttackResultView.swift

import SwiftUI

struct TimeAttackResultView: View {
    let didWin: Bool
    let score: Int
    let maxScore: Int
    let moves: Int
    let timeUsed: Int
    let tilesRemaining: Int
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(didWin ? "🎉 YOU WON!" : "⏱ TIME UP!")
                .font(.largeTitle)
                .bold()

            Text("Score: \(score) / \(maxScore)")
            Text("Moves: \(moves)")
            Text("Time Used: \(timeUsed)s")

            if !didWin {
                Text("Tiles Left: \(tilesRemaining)")
                    .foregroundColor(.red)
            }

            Button("OK") {
                onDismiss()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .frame(width: 320)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
    }
}
