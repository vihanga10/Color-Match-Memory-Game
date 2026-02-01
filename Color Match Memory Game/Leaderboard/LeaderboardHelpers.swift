
//  LeaderboardHelpers.swift

import SwiftUI

import Foundation

func tableHeader(_ titles: [String]) -> some View {
    HStack {
        ForEach(titles, id: \.self) {
            Text($0)
                .font(.caption)
                .bold()
                .frame(maxWidth: .infinity)
        }
    }
}

func row(_ values: [String]) -> some View {
    HStack {
        ForEach(values, id: \.self) {
            Text($0)
                .font(.caption)
                .frame(maxWidth: .infinity)
        }
    }
}
func formatTime(_ seconds: Int) -> String {
    let minutes = seconds / 60
    let remainingSeconds = seconds % 60
    return String(format: "%02d:%02d", minutes, remainingSeconds)
}
