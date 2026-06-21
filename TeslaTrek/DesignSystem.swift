import SwiftUI

// MARK: - Tesla Trek Design System (exact match to reference)

enum TTColors {
    static let bg = Color.black
    static let card = Color(red: 0.10, green: 0.10, blue: 0.13)
    static let cardBorder = Color.white.opacity(0.08)
    
    // Neon
    static let accentBlue = Color(red: 0.0, green: 0.75, blue: 1.0)       // #00BFFF / cyan-blue
    static let accentCyan = Color(red: 0.0, green: 0.95, blue: 1.0)
    static let accentRed = Color(red: 1.0, green: 0.23, blue: 0.19)        // END TRIP red
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let purple = Color(red: 0.58, green: 0.0, blue: 0.83)
    
    // Text
    static let primaryText = Color.white
    static let secondaryText = Color.white.opacity(0.7)
    static let muted = Color.white.opacity(0.5)
}

struct TTLogo: View {
    var size: CGFloat = 28
    var body: some View {
        HStack(spacing: 8) {
            // Red lightning T (approximated with SF + custom)
            ZStack {
                Image(systemName: "bolt.fill")
                    .font(.system(size: size * 0.9, weight: .black))
                    .foregroundStyle(TTColors.accentRed)
                    .shadow(color: TTColors.accentRed.opacity(0.6), radius: 4, x: 0, y: 0)
                
                Image(systemName: "bolt")
                    .font(.system(size: size * 0.9, weight: .black))
                    .foregroundStyle(.white)
                    .opacity(0.2)
            }
            Text("TESLA TREK")
                .font(.system(size: size, weight: .black, design: .rounded))
                .tracking(1.5)
                .foregroundStyle(.white)
        }
    }
}

// Glowing circle progress for Range
struct GlowingRing: View {
    var progress: Double // 0-1
    var valueText: String
    var label: String
    var size: CGFloat = 220
    
    var body: some View {
        ZStack {
            // Outer glow layers
            Circle()
                .stroke(TTColors.accentBlue.opacity(0.15), lineWidth: 18)
                .frame(width: size, height: size)
                .blur(radius: 16)
            
            Circle()
                .stroke(TTColors.accentBlue.opacity(0.25), lineWidth: 12)
                .frame(width: size, height: size)
                .blur(radius: 8)
            
            // Background ring
            Circle()
                .stroke(Color.white.opacity(0.08), lineWidth: 12)
                .frame(width: size, height: size)
            
            // Progress
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: [TTColors.accentBlue, TTColors.accentCyan, TTColors.accentBlue],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .shadow(color: TTColors.accentBlue, radius: 10, x: 0, y: 0)
                .shadow(color: TTColors.accentBlue.opacity(0.6), radius: 20, x: 0, y: 0)
            
            // Inner content
            VStack(spacing: 2) {
                Text("RANGE")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(TTColors.secondaryText)
                Text(valueText)
                    .font(.system(size: 52, weight: .black, design: .rounded))
                    .foregroundStyle(.white)
                Text(label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(TTColors.accentBlue)
            }
        }
    }
}

// Neon glowing button
struct NeonButton: View {
    var title: String
    var color: Color = TTColors.accentBlue
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color.opacity(0.15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(color, lineWidth: 1.5)
                        )
                )
                .foregroundStyle(color)
                .shadow(color: color.opacity(0.5), radius: 8, x: 0, y: 0)
        }
        .buttonStyle(.plain)
    }
}

// Red destructive button (END TRIP style)
struct DestructiveButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(TTColors.accentRed.opacity(0.15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(TTColors.accentRed, lineWidth: 1.5)
                        )
                )
                .foregroundStyle(TTColors.accentRed)
        }
        .buttonStyle(.plain)
    }
}

// Card container with subtle border + glow option
struct TTCARD<Content: View>: View {
    var hasGlow: Bool = false
    var glowColor: Color = TTColors.accentBlue
    @ViewBuilder var content: Content
    
    var body: some View {
        content
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(TTColors.card)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(TTColors.cardBorder, lineWidth: 1)
                    )
                    .shadow(color: hasGlow ? glowColor.opacity(0.3) : .clear, radius: hasGlow ? 16 : 0, x: 0, y: 0)
            )
    }
}

// Segmented control (Upcoming / Past style)
struct TTSegmentedControl: View {
    @Binding var selection: String
    let options: [String]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { option in
                Button {
                    withAnimation(.spring(response: 0.25)) {
                        selection = option
                    }
                } label: {
                    Text(option)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(
                            selection == option ?
                            RoundedRectangle(cornerRadius: 10)
                                .fill(TTColors.accentBlue)
                                .shadow(color: TTColors.accentBlue.opacity(0.5), radius: 6) :
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.clear)
                        )
                        .foregroundStyle(selection == option ? .black : TTColors.secondaryText)
                }
                .buttonStyle(.plain)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.06))
        )
        .padding(2)
    }
}
