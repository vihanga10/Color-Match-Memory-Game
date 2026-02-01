
//  LeaderboardEntry.swift

import Foundation

struct LeaderboardEntry: Identifiable, Codable {
    let id = UUID ()
    let playerName: String
    let difficulty: Difficulty
    let level: GameStage  // .normal or .timeAttack
    let score: Int
    let timeSpent: Int    // in seconds
    let moves: Int
    let pairsCompleted: Int?  // only for Level 2 (timeAttack), optional
    let tilesRemaining: Int? 
    let date: Date
}

