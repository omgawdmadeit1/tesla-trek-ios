import SwiftUI
import MapKit

struct MapHomeView: View {
    var user: User
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)
    )
    @State private var showNavigation = false
    
    var body: some View {
        ZStack {
            // Base map (dark feel)
            Map(position: .constant(.region(region))) {
                // Demo glowing route
                MapPolyline(coordinates: [
                    .init(latitude: 37.7749, longitude: -122.4194),
                    .init(latitude: 37.79, longitude: -122.40),
                    .init(latitude: 37.80, longitude: -122.41)
                ])
                .stroke(TTColors.accentBlue, lineWidth: 6)
            }
            .ignoresSafeArea()
            
            // Overlay UI
            VStack {
                // Top bar
                HStack {
                    TTLogo(size: 20)
                    Spacer()
                    Image(systemName: "bell.fill")
                        .foregroundStyle(.white.opacity(0.8))
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                Spacer()
                
                // Bottom HUD panel with range + quick start
                VStack(spacing: 18) {
                    // Large glowing Range circle
                    GlowingRing(
                        progress: Double(user.vehicle.range) / 400.0,
                        valueText: "\(user.vehicle.range)",
                        label: "mi"
                    )
                    .padding(.bottom, 8)
                    
                    // Quick action buttons
                    HStack(spacing: 12) {
                        NeonButton(title: "START TREK") {
                            showNavigation = true
                        }
                        .frame(maxWidth: .infinity)
                        
                        Button {
                            // Open full map / recent trek
                        } label: {
                            Image(systemName: "map.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(16)
                                .background(
                                    Circle()
                                        .fill(TTColors.card)
                                        .overlay(Circle().stroke(TTColors.cardBorder))
                                )
                                .foregroundStyle(TTColors.accentBlue)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 110)
                .background(
                    LinearGradient(
                        colors: [.clear, Color.black.opacity(0.85)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .fullScreenCover(isPresented: $showNavigation) {
            NavigationActiveView(onEndTrip: {
                showNavigation = false
            })
        }
    }
}
