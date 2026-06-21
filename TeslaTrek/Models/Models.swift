import SwiftUI
import Foundation
import CoreLocation

// MARK: - Core Models

struct User: Identifiable {
    let id = UUID()
    var name: String = "You"
    var level: Int = 12
    var xp: Int = 12500
    var xpToNext: Int = 15000
    var streak: Int = 7
    var totalXP: Int = 45200
    var rank: Int = 42
    var vehicle: Vehicle
}

struct Vehicle: Identifiable {
    let id = UUID()
    var model: String
    var icon: String // SF Symbol or emoji
    var range: Int // current estimated
}

struct Trip: Identifiable {
    let id = UUID()
    var title: String
    var distance: Double // miles
    var batteryNeeded: Double // percent
    var status: TripStatus
    var date: Date
    var thumbnail: String // placeholder description
    var checkpointsCompleted: Int?
    var totalCheckpoints: Int?
}

enum TripStatus: String {
    case upcoming = "Upcoming"
    case active = "Active"
    case pending = "Pending"
    case completed = "Completed"
    
    var color: Color {
        switch self {
        case .active: return .blue
        case .completed: return .gray
        case .pending: return .red
        case .upcoming: return .gray
        }
    }
}

struct Checkpoint: Identifiable {
    let id = UUID()
    var number: Int
    var coordinate: CLLocationCoordinate2D
    var title: String
    var isCompleted: Bool
}

struct CuratedTrek: Identifiable {
    let id = UUID()
    var name: String = "CURATED TREK"
    var difficulty: Int = 4
    var isEditorsPick: Bool = true
    var level: Int = 12
    var streak: Int = 7
    var checkpoints: [Checkpoint]
    var completedCount: Int
    var totalCheckpoints: Int
    var rewardXP: Int = 500
    var rewardCoins: Int = 50
}

struct Badge: Identifiable {
    let id = UUID()
    var name: String
    var rarity: Rarity
    var unlockedDate: String?
    var progress: Double // 0-1
    var current: Int?
    var total: Int?
    var icon: String // system or description
}

enum Rarity: String {
    case common = "COMMON"
    case rare = "RARE"
    case epic = "EPIC"
    case legendary = "LEGENDARY"
    
    var color: Color {
        switch self {
        case .common: return .gray
        case .rare: return .yellow
        case .epic: return .purple
        case .legendary: return .orange
        }
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    var rank: Int
    var name: String
    var xp: Int
    var avatarColor: Color
    var time: String?
    var isCurrentUser: Bool = false
}

struct Reward {
    var title: String
    var xp: Int
    var badges: [String]
    var theme: String?
    var bonus: String?
}

// Mock Data
extension User {
    static let demo = User(
        level: 12,
        xp: 12500,
        xpToNext: 15000,
        streak: 7,
        totalXP: 45200,
        rank: 42,
        vehicle: Vehicle(model: "Cybertruck", icon: "car", range: 315)
    )
}

extension Trip {
    static let mockTrips: [Trip] = [
        Trip(title: "Summit Run", distance: 87, batteryNeeded: 42, status: .pending, date: Date(), thumbnail: "mountains"),
        Trip(title: "Coastal Loop", distance: 124, batteryNeeded: 65, status: .active, date: Date().addingTimeInterval(-3600*5), thumbnail: "coast"),
        Trip(title: "Desert Crossing", distance: 210, batteryNeeded: 88, status: .completed, date: Date().addingTimeInterval(-86400*2), thumbnail: "desert", checkpointsCompleted: 7, totalCheckpoints: 7)
    ]
}

extension CuratedTrek {
    static let demo = CuratedTrek(
        checkpoints: [
            Checkpoint(number: 1, coordinate: .init(latitude: 37.7749, longitude: -122.4194), title: "Start", isCompleted: true),
            Checkpoint(number: 2, coordinate: .init(latitude: 37.7849, longitude: -122.4094), title: "Vista", isCompleted: true),
            Checkpoint(number: 3, coordinate: .init(latitude: 37.7949, longitude: -122.3994), title: "Summit", isCompleted: true),
            Checkpoint(number: 4, coordinate: .init(latitude: 37.8049, longitude: -122.3894), title: "Crater", isCompleted: true),
            Checkpoint(number: 5, coordinate: .init(latitude: 37.8149, longitude: -122.3794), title: "Lake", isCompleted: false),
            Checkpoint(number: 6, coordinate: .init(latitude: 37.8249, longitude: -122.3694), title: "Ridge", isCompleted: false),
            Checkpoint(number: 7, coordinate: .init(latitude: 37.8349, longitude: -122.3594), title: "Finish", isCompleted: false)
        ],
        completedCount: 4,
        totalCheckpoints: 7
    )
}

extension Badge {
    static let demoBadges: [Badge] = [
        Badge(name: "SUMMIT SEEKER", rarity: .rare, unlockedDate: "OCT 24", progress: 0.95, current: 950, total: 1000, icon: "mountain.2.fill"),
        Badge(name: "NIGHT RIDER", rarity: .epic, unlockedDate: nil, progress: 0.3, current: 300, total: 1000, icon: "moon.stars.fill"),
        Badge(name: "CYBER PIONEER", rarity: .legendary, unlockedDate: "SEP 12", progress: 1.0, icon: "bolt.car.fill")
    ]
}

extension LeaderboardEntry {
    static let demoGlobal: [LeaderboardEntry] = [
        .init(rank: 1, name: "ALEX", xp: 9500, avatarColor: .yellow, time: nil),
        .init(rank: 2, name: "JORDAN", xp: 8200, avatarColor: .blue, time: nil),
        .init(rank: 3, name: "TAYLOR", xp: 7100, avatarColor: .orange, time: nil),
        .init(rank: 4, name: "CASEY", xp: 6000, avatarColor: .green, time: nil),
        .init(rank: 12, name: "YOU", xp: 2500, avatarColor: .cyan, time: nil, isCurrentUser: true)
    ]
    
    static let demoThisTrek: [LeaderboardEntry] = [
        .init(rank: 1, name: "YOU", xp: 2500, avatarColor: .cyan, time: "Time 0h 12m", isCurrentUser: true),
        .init(rank: 2, name: "SAM", xp: 2100, avatarColor: .purple, time: "Time 0h 18m"),
        .init(rank: 3, name: "RILEY", xp: 1950, avatarColor: .red, time: "Time 0h 22m")
    ]
}
