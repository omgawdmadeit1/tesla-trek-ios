import SwiftUI

struct ProfileView: View {
    @Binding var user: User
    @State private var darkMode = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        TTLogo(size: 22)
                        Spacer()
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(TTColors.secondaryText)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    Text("Profile")
                        .font(.system(size: 34, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    // Avatar with neon ring (exact blue-red gradient)
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [TTColors.accentBlue, TTColors.accentRed],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 5
                            )
                            .frame(width: 120, height: 120)
                            .blur(radius: 4)
                        
                        Circle()
                            .fill(TTColors.card)
                            .frame(width: 108, height: 108)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 52))
                                    .foregroundStyle(TTColors.secondaryText)
                            )
                    }
                    .padding(.top, 8)
                    
                    // Vehicle card
                    TTCARD {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("VEHICLE MODEL")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(TTColors.muted)
                                Text(user.vehicle.model)
                                    .font(.system(size: 20, weight: .bold))
                            }
                            Spacer()
                            Image(systemName: "car.fill")
                                .font(.system(size: 42))
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Settings list
                    VStack(spacing: 0) {
                        SettingsRow(icon: "bell.fill", title: "Notifications", action: {})
                        Divider().background(Color.white.opacity(0.08))
                        SettingsRow(icon: "ruler", title: "Units", action: {})
                        Divider().background(Color.white.opacity(0.08))
                        SettingsRow(icon: "map.fill", title: "Offline Maps", action: {})
                        Divider().background(Color.white.opacity(0.08))
                        SettingsRow(icon: "person.crop.circle", title: "Account", action: {})
                        Divider().background(Color.white.opacity(0.08))
                        SettingsRow(icon: "questionmark.circle", title: "Support", action: {})
                        Divider().background(Color.white.opacity(0.08))
                        
                        // Dark Mode toggle - exact match
                        HStack {
                            Label {
                                Text("Dark Mode")
                                    .font(.system(size: 17, weight: .regular))
                            } icon: {
                                Image(systemName: "moon.fill")
                                    .foregroundStyle(TTColors.accentBlue)
                            }
                            Spacer()
                            Toggle("", isOn: $darkMode)
                                .labelsHidden()
                                .tint(TTColors.accentBlue)
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                        
                        Divider().background(Color.white.opacity(0.08))
                        
                        Button(role: .destructive) {
                            // Sign out stub
                        } label: {
                            HStack {
                                Image(systemName: "power")
                                Text("Sign Out")
                                    .font(.system(size: 17, weight: .regular))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundStyle(TTColors.accentRed)
                        }
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(TTColors.card)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(TTColors.cardBorder, lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 60)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

private struct SettingsRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundStyle(TTColors.accentBlue)
                    .frame(width: 28)
                Text(title)
                    .font(.system(size: 17))
                    .foregroundStyle(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(TTColors.muted)
            }
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}
