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
            ZStack {
                LinearGradient(
                    colors: [
                        Color.white,
                        Color(red: 183/255, green: 211/255, blue: 228/255) // #B7D3E4
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 35) {

                    Text("BRAIN HUE")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(red: 55/255, green: 100/255, blue: 140/255))
                        .padding(.top, 40)

                    LevelButton(
                        title: "Beginner Level",
                        imageName: "beginner_icon",
                        difficulty: .beginner                    )

                    LevelButton(
                        title: "Intermediate Level",
                        imageName: "intermediate_icon",
                        difficulty: .intermediate
                    )

                    LevelButton(
                        title: "Master Level",
                        imageName: "master_icon",
                        difficulty: .master                    )

                    Spacer()

                    Button("LEADERBOARD") { }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 45)
                        .background(
                            Color(red: 79/255, green: 113/255, blue: 145/255) // #4F7191
                        )
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.25), radius: 6, y: 4)
                        .padding(.bottom, 30)
                }
            }
        }
    }
}

struct LevelButton: View {
    let title: String
    let imageName: String
    let difficulty: Difficulty

    @State private var isHovering = false

    var body: some View {
        VStack(spacing: 12) {

            NavigationLink {
                PlayerInfoView(difficulty: difficulty)
            } label: {

                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 110, height: 110)

                    Circle()
                        .stroke(
                            Color(red: 176/255, green: 201/255, blue: 224/255), // #B0C9E0
                            lineWidth: 6
                        )
                        .frame(width: 110, height: 110)

                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                }
                .scaleEffect(isHovering ? 1.08 : 1.0)
                .shadow(
                    color: Color(red: 176/255, green: 201/255, blue: 224/255)
                        .opacity(isHovering ? 0.6 : 0),
                    radius: isHovering ? 14 : 0
                )
                .animation(.easeInOut(duration: 0.25), value: isHovering)

            }
            .buttonStyle(.plain)
            .onHover { isHovering = $0 }

            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(Color(red: 31/255, green: 64/255, blue: 104/255)) // #1F4068

        }
    }
}





