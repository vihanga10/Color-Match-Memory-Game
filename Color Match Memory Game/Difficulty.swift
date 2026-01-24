
//  Difficulty.swift

import SwiftUI

enum Difficulty {
    case beginner
    case intermediate
    case master

    var rows: Int {
        switch self {
        case .beginner: return 3
        case .intermediate: return 5
        case .master: return 7
        }
    }

    var cols: Int {
        rows
    }

    var pairsCount: Int {
        switch self {
        case .beginner: return 4      // 4 pairs + 1 bonus = 5
        case .intermediate: return 12 // 12 pairs + 1 bonus = 13
        case .master: return 24       // 24 pairs + 1 bonus = 25
        }
    }

    var bonusTiles: Int {
        1
    }

    var maxScore: Int {
        pairsCount + bonusTiles
    }
}
