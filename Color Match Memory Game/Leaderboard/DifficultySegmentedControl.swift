//
//  DifficultySegmentedControl.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-02-01.
//

import SwiftUI

struct DifficultySegmentedControl: View {
    @Binding var selected: Difficulty

    var body: some View {
        HStack(spacing: 0) {
            segment(title: "Beginner", value: .beginner)
            Divider()
            segment(title: "Intermediate", value: .intermediate)
            Divider()
            segment(title: "Master", value: .master)
        }
        .frame(height: 44)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 5)
    }

    private func segment(title: String, value: Difficulty) -> some View {
        Button {
            selected = value
        } label: {
            Text(title)
                .font(.subheadline)
                .foregroundColor(selected == value ? .white : .blue)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selected == value ? Color.blue : Color.clear)
                .cornerRadius(30)
                .padding(.vertical, 6)
        }
    }
}
