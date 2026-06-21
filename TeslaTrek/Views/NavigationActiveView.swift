import SwiftUI
import MapKit

struct NavigationActiveView: View {
    var onEndTrip: () -> Void
    @State private var showReward = false
    
    var body: some View {
        ZStack {
            // Dark map background
            Map() {
                MapPolyline(coordinates: [
                    .init(latitude: 37.78, longitude: -122.42),
                    .init(latitude: 37.79, longitude: -122.405)
                ])
                .stroke(TTColors.accentBlue, lineWidth: 7)
            }
            .ignoresSafeArea()
            
            // Top HUD
            VStack {
                HStack {
                    TTLogo(size: 18)
                    Spacer()
                    VStack(alignment: .trailing, spacing: -2) {
                        Text("CYBERTRUCK")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(TTColors.secondaryText)
                        Text("45 MI")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.green)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                // Turn instruction card (exact)
                VStack(spacing: 6) {
                    HStack {
                        Image(systemName: "arrow.turn.up.left")
                            .font(.system(size: 42, weight: .black))
                            .foregroundStyle(.white)
                        
                        VStack(alignment: .leading, spacing: -4) {
                            Text("0.8 MI")
                                .font(.system(size: 48, weight: .black))
                                .foregroundStyle(.white)
                            Text("CYBERTRUCK")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(TTColors.secondaryText)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black.opacity(0.75))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white.opacity(0.1), lineWidth: 1)
                            )
                    )
                    
                    // ETA and range strip
                    HStack {
                        Text("ETA 10:45 AM")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(TTColors.secondaryText)
                        
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Label("12 MI", systemImage: "location.fill")
                                .font(.system(size: 13, weight: .semibold))
                            Label("45 MI", systemImage: "bolt.fill")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(.green)
                        }
                    }
                    .padding(.horizontal, 6)
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Bottom controls
                VStack(spacing: 12) {
                    DestructiveButton(title: "END TRIP") {
                        showReward = true
                    }
                    .padding(.horizontal, 20)
                    
                    // Mini map button
                    Button {
                        // center on location
                    } label: {
                        HStack {
                            Image(systemName: "map.fill")
                            Text("MAP")
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .background(Capsule().fill(TTColors.card))
                        .overlay(Capsule().stroke(TTColors.cardBorder))
                    }
                }
                .padding(.bottom, 90)
            }
        }
        .sheet(isPresented: $showReward) {
            RewardModal(
                reward: Reward(title: "TREK COMPLETE", xp: 500, badges: ["SUMMIT SEEKER"]),
                onContinue: {
                    showReward = false
                    onEndTrip()
                }
            )
        }
    }
}
