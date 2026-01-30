
//  PlayerInfoView.swift


import SwiftUI

struct PlayerInfoView: View {

    let difficulty: Difficulty

    @State private var name: String = ""
    @State private var age: String = ""

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.white,
                    Color(red: 183/255, green: 211/255, blue: 228/255) // #B7D3E4
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 25) {

                // Title
                Text(difficultyTitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(Color(red: 55/255, green: 100/255, blue: 140/255))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)

                // Name
                Text("Name")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 79/255, green: 113/255, blue: 145/255))

                TextField("Enter your name", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.08), radius: 6)

                // Age
                Text("Age")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color(red: 79/255, green: 113/255, blue: 145/255))

                TextField("Enter your age", text: $age)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.08), radius: 6)

                Spacer()

                // Play button
                NavigationLink {
                    GameView(
                        difficulty: difficulty,
                        playerName: name,
                        playerAge: Int(age) ?? 0
                    )
                } label: {
                    Text("PLAY")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 45)
                        .background(Color(red: 79/255, green: 113/255, blue: 145/255))
                        .cornerRadius(5)
                        .shadow(color: .black.opacity(0.25), radius: 6, y: 4)
                }
                .disabled(name.isEmpty || age.isEmpty)
                .opacity(name.isEmpty || age.isEmpty ? 0.6 : 1)

                Spacer().frame(height: 30)
            }
            .padding(.horizontal, 30)
        }
    }

    private var difficultyTitle: String {
        switch difficulty {
        case .beginner: return "BEGINNER LEVEL"
        case .intermediate: return "INTERMEDIATE LEVEL"
        case .master: return "MASTER LEVEL"
        }
    }
}
