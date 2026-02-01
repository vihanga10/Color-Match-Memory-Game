
//  LeaderboardManager.swift


import Combine
import Foundation

class LeaderboardManager: ObservableObject {
    @Published var entries: [LeaderboardEntry] = []
    
    private let storageKey = "leaderboardEntries"
    
    init() {
        load()
    }
    
    func addEntry(_ entry: LeaderboardEntry) {
        entries.append(entry)
        save()
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([LeaderboardEntry].self, from: data) {
            entries = decoded
        }
    }
    
    func entriesFor(difficulty: Difficulty, level: GameStage) -> [LeaderboardEntry] {
        entries.filter { $0.difficulty == difficulty && $0.level == level }
            .sorted { $0.score > $1.score }
    }
}
