
//  Level2Table.swift

import SwiftUI

struct Level2Table: View {
    let entries: [LeaderboardEntry]

    var body: some View {
        VStack(spacing: 8) {
            tableHeader(["Name", "Points", "Moves", "Pairs", "Left", "Time"])

            ForEach(entries) { entry in
                row([
                    entry.playerName,
                    "\(entry.score)",
                    "\(entry.moves)",
                    "\(entry.pairsCompleted ?? 0)",
                    "\(entry.tilesRemaining ?? 0)",
                    formatTime(entry.timeSpent)
                ])
            }
        }
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
