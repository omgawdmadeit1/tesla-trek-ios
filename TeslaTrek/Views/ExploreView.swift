import SwiftUI
import MapKit

struct ExploreView: View {
    var user: User
    @State private var showReward = false
    @State private var selectedTrek = CuratedTrek.demo
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Header
                    HStack {
                        TTLogo(size: 22)
                        Spacer()
                        Image(systemName: "bell.fill").foregroundStyle(TTColors.secondaryText)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // Curated Trek header card
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text(selectedTrek.name)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(TTColors.secondaryText)
                                
                                HStack(spacing: 4) {
                                    ForEach(0..<selectedTrek.difficulty, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 13))
                                            .foregroundStyle(TTColors.gold)
                                    }
                                    Text("DIFFICULTY")
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundStyle(TTColors.muted)
                                }
                            }
                            Spacer()
                            
                            if selectedTrek.isEditorsPick {
                                Text("EDITOR'S PICK")
                                    .font(.system(size: 11, weight: .black))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(
                                        Capsule()
                                            .fill(TTColors.gold.opacity(0.2))
                                    )
                                    .foregroundStyle(TTColors.gold)
                                    .overlay(
                                        Capsule().stroke(TTColors.gold.opacity(0.6), lineWidth: 0.5)
                                    )
                            }
                        }
                        
                        // Mini map preview + route (simplified styled map)
                        ZStack(alignment: .bottomTrailing) {
                            Map(interactionModes: []) {
                                // Glowing styled polyline simulation
                                MapPolyline(coordinates: selectedTrek.checkpoints.map { $0.coordinate })
                                    .stroke(TTColors.accentBlue, lineWidth: 5)
                            }
                            .frame(height: 260)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(TTColors.accentBlue.opacity(0.3), lineWidth: 1)
                            )
                            
                            // Checkpoint numbers overlay (exact visual)
                            VStack {
                                Spacer()
                                HStack {
                                    ForEach(selectedTrek.checkpoints) { cp in
                                        ZStack {
                                            Circle()
                                                .fill(cp.isCompleted ? TTColors.accentBlue : Color.black.opacity(0.6))
                                                .frame(width: 22, height: 22)
                                                .overlay(Circle().stroke(.white.opacity(0.6), lineWidth: 1))
                                            
                                            Text("\(cp.number)")
                                                .font(.system(size: 11, weight: .black))
                                                .foregroundStyle(.white)
                                        }
                                        .shadow(color: cp.isCompleted ? TTColors.accentBlue : .clear, radius: 6)
                                    }
                                }
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                            }
                            .padding(12)
                        }
                        
                        // Stats row
                        HStack(spacing: 20) {
                            StatPill(icon: "flame.fill", value: "\(selectedTrek.streak)", label: "7 DAY STREAK", color: .orange)
                            StatPill(icon: "shield.fill", value: "LVL \(selectedTrek.level)", label: "", color: TTColors.accentBlue)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("4 OF 7")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(TTColors.secondaryText)
                                Text("CHECKPOINTS")
                                    .font(.system(size: 10))
                                    .foregroundStyle(TTColors.muted)
                            }
                        }
                        
                        // Continue button
                        NeonButton(title: "CONTINUE TREK", color: TTColors.accentBlue) {
                            // Start the trek navigation flow
                            showReward = true
                        }
                        .padding(.top, 4)
                        
                        // Rewards footer
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundStyle(TTColors.gold)
                            Text("+\(selectedTrek.rewardXP) XP   +\(selectedTrek.rewardCoins) COINS")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(TTColors.secondaryText)
                            Spacer()
                        }
                        .padding(.top, 2)
                    }
                    .padding(18)
                    .background(TTColors.card)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    
                    // Badges row (horizontal scroll)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("BADGES")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(TTColors.muted)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(Badge.demoBadges) { badge in
                                    BadgeMini(badge: badge) {
                                        // TODO: present BadgeDetailView in a real sheet
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.top, 24)
                    
                    // Leaderboard (exact style from reference)
                    LeaderboardView(entries: LeaderboardEntry.demoGlobal, title: "GLOBAL RANKS")
                        .padding(.top, 16)
                    
                    Spacer(minLength: 100)
                }
            }
            .background(TTColors.bg)
            .sheet(isPresented: $showReward) {
                RewardModal(
                    reward: Reward(title: "TREK COMPLETE", xp: 500, badges: ["SUMMIT SEEKER"], theme: "TRAIL THEME"),
                    onContinue: { showReward = false }
                )
            }
        }
    }
}

struct StatPill: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundStyle(color)
            VStack(alignment: .leading, spacing: 0) {
                Text(value)
                    .font(.system(size: 16, weight: .bold))
                if !label.isEmpty {
                    Text(label)
                        .font(.system(size: 10))
                        .foregroundStyle(TTColors.muted)
                }
            }
        }
    }
}

struct BadgeMini: View {
    let badge: Badge
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    Circle()
                        .fill(badge.rarity.color.opacity(0.15))
                        .frame(width: 58, height: 58)
                    Image(systemName: badge.icon)
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(badge.rarity.color)
                        .shadow(color: badge.rarity.color.opacity(0.5), radius: 6)
                }
                Text(badge.name.replacingOccurrences(of: " ", with: "\n"))
                    .font(.system(size: 9, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .lineLimit(2)
            }
            .frame(width: 72)
        }
        .buttonStyle(.plain)
    }
}
