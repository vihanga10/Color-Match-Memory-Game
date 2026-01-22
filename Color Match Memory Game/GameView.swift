//
//  GameView.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//
import SwiftUI

struct GameView: View {

    let difficulty: Difficulty
    let playerName: String
    let playerAge: Int

    @StateObject private var viewModel = GameViewModel()

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible(), spacing: 12),
            count: difficulty.gridSize.cols
        )
    }

    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color.white,
                    Color(red: 183/255, green: 211/255, blue: 228/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {

                // Top Bar
                HStack {
                    NavigationLink(destination: DashboardView()) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color(red: 55/255, green: 100/255, blue: 140/255))
                    }

                    Spacer()

                    Button {
                        viewModel.resetGame(difficulty: difficulty)
                    } label: {
                        Text("RESET")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.red)
                            .cornerRadius(6)
                            .shadow(radius: 4)
                    }
                }
                .padding(.horizontal)

                // Level Title
                Text(levelTitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 55/255, green: 100/255, blue: 140/255))

                // Player Name
                Text("Hello \(playerName) !")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(Color(red: 55/255, green: 100/255, blue: 140/255))

                // Level Progress (1–2–3)
                HStack(spacing: 0) {
                    levelCircle(number: 1, active: true)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                        .frame(maxWidth: 40)
                    levelCircle(number: 2, active: false)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.black)
                        .frame(maxWidth: 40)
                    levelCircle(number: 3, active: false)
                }
                .padding(.vertical, 10)

                // Game Grid
                LazyVGrid(columns: columns, spacing: 14) {
                    ForEach(viewModel.tiles.indices, id: \.self) { index in
                        TileView(tile: viewModel.tiles[index])
                            .onTapGesture {
                                viewModel.selectTile(index)
                            }
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(.horizontal)

                // Stats Section
                HStack {
                    statView(title: "TIME", value: viewModel.formattedTime, color: .red)
                    statView(title: "MOVES", value: "\(viewModel.moves)", color: .black)
                    statView(title: "POINTS", value: "\(viewModel.score)", color: .blue)
                }
                .padding(.top, 10)

                Spacer()
            }
            .padding(.top)
        }
        .onAppear {
            viewModel.resetGame(difficulty: difficulty)
        }
    }

    // MARK: - Components

    private var levelTitle: String {
        switch difficulty {
        case .easy: return "BEGINNER LEVEL"
        case .medium: return "INTERMEDIATE LEVEL"
        case .hard: return "MASTER LEVEL"
        }
    }

    private func statView(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.headline)
            Text(value)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
    }

    private func levelCircle(number: Int, active: Bool) -> some View {
        ZStack {
            Circle()
                .fill(active ? Color(red: 79/255, green: 113/255, blue: 145/255) : Color.gray.opacity(0.3))
                .frame(width: 40, height: 40)

            Text("\(number)")
                .foregroundColor(active ? .white : .gray)
                .fontWeight(.bold)
        }
    }
}
