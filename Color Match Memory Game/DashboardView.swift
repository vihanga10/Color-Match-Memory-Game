//
//  DashboardView.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("BrainHue")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                NavigationLink("Easy (3×3)", value: Difficulty.easy)
                    .buttonStyle(DifficultyButtonStyle())

                NavigationLink("Medium (5×5)", value: Difficulty.medium)
                    .buttonStyle(DifficultyButtonStyle())

                NavigationLink("Hard (7×7)", value: Difficulty.hard)
                    .buttonStyle(DifficultyButtonStyle())
            }
            .navigationDestination(for: Difficulty.self) { difficulty in
                GameView(difficulty: difficulty)
            }
            .padding()
        }
    }
}

enum Difficulty: Hashable {
    case easy, medium, hard

    var gridSize: (rows: Int, cols: Int) {
        switch self {
        case .easy: return (3, 3)   // 9 tiles
        case .medium: return (5, 5) // 25 tiles
        case .hard: return (7, 7)   // 49 tiles
        }
    }

    var totalTiles: Int {
        gridSize.rows * gridSize.cols
    }

    var pairsCount: Int {
        // 1 extra tile reserved for block icon
        // So pairs count = (totalTiles - 1) / 2
        (totalTiles - 1) / 2
    }
}


struct DifficultyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 220, height: 50)
            .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .font(.headline)
            .shadow(radius: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
