
//  Level1Table.swift


import SwiftUI

struct Level1Table: View {
    let entries: [LeaderboardEntry]

    var body: some View {
        VStack(spacing: 8) {
            tableHeader(["Name", "Points", "Moves", "Time"])

            ForEach(entries) { entry in
                row([
                    entry.playerName,
                    "\(entry.score)",
                    "\(entry.moves)",
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
