
//  WinPopupView.swift

import SwiftUI

struct WinPopupView: View {

    let difficulty: Difficulty
    let score: Int
    let time: String
    let onYes: () -> Void
    let onNo: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Text("🎉 YOU WIN 🎉")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.green)

            VStack(spacing: 10) {
                Text("Level Completed")
                    .font(.headline)

                Text("Score: \(score)")
                    .font(.title3)

                Text("Time: \(time)")
                    .font(.title3)
            }

            Divider()

            if difficulty != .master {
                Text("Unlock Next Level?")
                    .font(.headline)
            } else {
                Text("All Levels Completed 🏆")
                    .font(.headline)
            }

            HStack(spacing: 20) {
                Button(action: onNo) {
                    Text("NO")
                        .foregroundColor(.white)
                        .frame(width: 120, height: 44)
                        .background(Color.gray)
                        .cornerRadius(8)
                }

                if difficulty != .master {
                    Button(action: onYes) {
                        Text("YES")
                            .foregroundColor(.white)
                            .frame(width: 120, height: 44)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
        }
        .padding(25)
        .frame(maxWidth: 320)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 15)
    }
}
