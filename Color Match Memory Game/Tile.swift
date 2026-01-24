
//  Tile.swift


import SwiftUI

struct Tile: Identifiable {
    let id = UUID()
    let color: Color?
    
    var isFlipped = false
    var isMatched = false
    var isBonus = false
}

