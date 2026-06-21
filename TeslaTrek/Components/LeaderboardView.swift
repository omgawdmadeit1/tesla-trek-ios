import SwiftUI

struct LeaderboardView: View {
    var entries: [LeaderboardEntry]
    var title: String = "GLOBAL RANKS"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .padding(.horizontal, 4)
            
            VStack(spacing: 0) {
                ForEach(entries) { entry in
                    HStack(spacing: 14) {
                        Text("\(entry.rank)")
                            .font(.system(size: 15, weight: .black))
                            .foregroundStyle(entry.isCurrentUser ? TTColors.accentBlue : TTColors.secondaryText)
                            .frame(width: 24, alignment: .trailing)
                        
                        Circle()
                            .fill(entry.avatarColor)
                            .frame(width: 26, height: 26)
                            .overlay(Circle().stroke(.white.opacity(0.3), lineWidth: 1))
                        
                        Text(entry.name)
                            .font(.system(size: 16, weight: entry.isCurrentUser ? .bold : .regular))
                        
                        Spacer()
                        
                        if let t = entry.time {
                            Text(t)
                                .font(.system(size: 12))
                                .foregroundStyle(TTColors.muted)
                        }
                        
                        Text("\(entry.xp) XP")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(TTColors.accentBlue)
                    }
                    .padding(.vertical, 11)
                    .padding(.horizontal, 14)
                    .background(
                        entry.isCurrentUser ?
                        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.04)) : nil
                    )
                    
                    if entry.id != entries.last?.id {
                        Divider().background(Color.white.opacity(0.06))
                    }
                }
            }
            .background(TTColors.card)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.horizontal, 20)
    }
}
