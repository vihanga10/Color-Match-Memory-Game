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

                Text("Select Difficulty")
                    .font(.title2)

                NavigationLink("Easy (3x2)", value: Difficulty.easy)
                    .buttonStyle(DifficultyButtonStyle())

                NavigationLink("Medium (4x4)", value: Difficulty.medium)
                    .buttonStyle(DifficultyButtonStyle())

                NavigationLink("Hard (6x6)", value: Difficulty.hard)
                    .buttonStyle(DifficultyButtonStyle())
            }
            .navigationDestination(for: Difficulty.self) { difficulty in
                GameView(difficulty: difficulty)
            }
        }
    }
}

enum Difficulty: Hashable {
    case easy, medium, hard

    var gridSize: (rows: Int, cols: Int) {
        switch self {
        case .easy: return (3, 2)
        case .medium: return (4, 4)
        case .hard: return (6, 6)
        }
    }

    var pairsCount: Int {
        let totalTiles = gridSize.rows * gridSize.cols
        return totalTiles / 2
    }
}

struct DifficultyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 50)
            .background(Color.pastelBlue.opacity(configuration.isPressed ? 0.6 : 1))
            .foregroundColor(.white)
            .cornerRadius(12)
            .font(.headline)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
