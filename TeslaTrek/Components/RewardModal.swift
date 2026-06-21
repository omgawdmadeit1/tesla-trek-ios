import SwiftUI

struct RewardModal: View {
    var reward: Reward
    var onContinue: () -> Void
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.96).ignoresSafeArea()
            
            VStack(spacing: 22) {
                // Confetti / burst effect (simplified)
                ZStack {
                    ForEach(0..<18) { i in
                        Circle()
                            .fill([TTColors.accentBlue, TTColors.gold, TTColors.accentCyan].randomElement()!)
                            .frame(width: CGFloat.random(in: 4...9))
                            .offset(
                                x: cos(Double(i) * 1.1) * 110,
                                y: sin(Double(i) * 0.9) * -70 + CGFloat(i % 3) * -20
                            )
                            .opacity(0.9)
                    }
                    
                    VStack(spacing: 4) {
                        Text("14")
                            .font(.system(size: 86, weight: .black))
                            .foregroundStyle(TTColors.gold)
                            .shadow(color: TTColors.gold.opacity(0.5), radius: 20)
                        
                        Text("LEVEL 10")
                            .font(.system(size: 14, weight: .black))
                            .tracking(3)
                            .foregroundStyle(TTColors.gold)
                    }
                }
                .frame(height: 180)
                
                Text("+\(reward.xp) XP")
                    .font(.system(size: 28, weight: .black))
                    .foregroundStyle(TTColors.gold)
                
                // Progress bar
                ProgressView(value: 0.68)
                    .tint(TTColors.accentBlue)
                    .scaleEffect(x: 1, y: 2.2)
                    .padding(.horizontal, 40)
                
                // Unlocks
                VStack(spacing: 10) {
                    RewardRow(icon: "shield.fill", title: "NEW BADGE")
                    RewardRow(icon: "paintbrush.fill", title: "TRAIL THEME")
                    RewardRow(icon: "bolt.fill", title: "RANGE BONUS")
                }
                .padding(.top, 8)
                
                NeonButton(title: "CONTINUE TREK") {
                    onContinue()
                    dismiss()
                }
                .padding(.horizontal, 32)
                .padding(.top, 12)
            }
        }
    }
}

private struct RewardRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(TTColors.accentBlue)
            Text(title)
                .font(.system(size: 16, weight: .semibold))
            Spacer()
        }
        .padding(.horizontal, 40)
    }
}

// Standalone Level 10 screen used in flows
struct LevelUpView: View {
    var onDone: () -> Void
    
    var body: some View {
        RewardModal(
            reward: Reward(title: "LEVEL 10", xp: 500, badges: ["MASTER EXPLORER"]),
            onContinue: onDone
        )
    }
}

// Badge detail modal (exact)
struct BadgeDetailView: View {
    let badge: Badge
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.9).ignoresSafeArea()
            
            VStack(spacing: 28) {
                ZStack {
                    Circle()
                        .fill(badge.rarity.color.opacity(0.12))
                        .frame(width: 140, height: 140)
                        .blur(radius: 30)
                    
                    Image(systemName: badge.icon)
                        .font(.system(size: 72))
                        .foregroundStyle(badge.rarity.color)
                        .shadow(color: badge.rarity.color, radius: 20)
                }
                
                VStack(spacing: 6) {
                    Text(badge.name.uppercased())
                        .font(.system(size: 26, weight: .black))
                    
                    Text(badge.rarity.rawValue)
                        .font(.system(size: 13, weight: .black))
                        .foregroundStyle(badge.rarity.color)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(badge.rarity.color.opacity(0.2)))
                }
                
                if let date = badge.unlockedDate {
                    Text("UNLOCKED: \(date)")
                        .font(.system(size: 13))
                        .foregroundStyle(TTColors.muted)
                }
                
                if let cur = badge.current, let tot = badge.total {
                    VStack(spacing: 6) {
                        ProgressView(value: Double(cur) / Double(tot))
                            .tint(TTColors.accentCyan)
                            .scaleEffect(x: 1, y: 2)
                        
                        Text("\(cur) / \(tot)")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(TTColors.secondaryText)
                    }
                    .padding(.horizontal, 60)
                }
                
                Button("CLOSE") { dismiss() }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(TTColors.secondaryText)
                    .padding(.top, 20)
            }
            .padding()
        }
    }
}
