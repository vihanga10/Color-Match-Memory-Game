
//  Difficulty.swift

import SwiftUI

enum Difficulty : String, Codable {
    case beginner
    case intermediate
    case master

    // MARK: - TITLE (FOR UI)
    var title: String {
        switch self {
        case .beginner: return "BEGINNER LEVEL"
        case .intermediate: return "INTERMEDIATE LEVEL"
        case .master: return "MASTER LEVEL"
        }
    }

    // MARK: - GRID SIZE
    var rows: Int {
        switch self {
        case .beginner: return 3
        case .intermediate: return 5
        case .master: return 7
        }
    }

    var cols: Int { rows }

    // MARK: - PAIRS
    var pairsCount: Int {
        switch self {
        case .beginner: return 4
        case .intermediate: return 12
        case .master: return 24
        }
    }

    // MARK: - BONUS
    var bonusTiles: Int { 1 }

    // MARK: - LEVEL 1 (NORMAL MODE)
    var normalPointsPerPair: Int { 1 }
    var normalBonusPoints: Int { 1 }

    var normalMaxScore: Int {
        (pairsCount * normalPointsPerPair) + normalBonusPoints
    }

    // MARK: - LEVEL 2 (TIME ATTACK MODE)
    var timeAttackPointsPerPair: Int { 10 }
    var timeAttackBonusPoints: Int { 10 }

    var timeAttackMaxScore: Int {
        (pairsCount * timeAttackPointsPerPair) + timeAttackBonusPoints
    }
}
