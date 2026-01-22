import SwiftUI

struct Tile: Identifiable {
    let id = UUID()
    let color: Color?
    
    var isFlipped = false
    var isMatched = false
    var isBonus = false
}


//
//  Tile.swift
//  Color Match Memory Game
//
//  Created by Vihanga Madushamini on 2026-01-17.
//

