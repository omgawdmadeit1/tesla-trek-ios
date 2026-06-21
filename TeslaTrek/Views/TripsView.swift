import SwiftUI

struct TripsView: View {
    @State private var segment = "Upcoming"
    let trips = Trip.mockTrips
    
    var filtered: [Trip] {
        switch segment {
        case "Upcoming": return trips.filter { $0.status == .upcoming || $0.status == .pending }
        case "Past": return trips.filter { $0.status == .completed || $0.status == .active }
        default: return trips
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    HStack {
                        TTLogo(size: 22)
                        Spacer()
                        Image(systemName: "bell.fill")
                            .foregroundStyle(TTColors.secondaryText)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    Text("Trips")
                        .font(.system(size: 34, weight: .bold))
                        .padding(.horizontal, 20)
                    
                    // Segmented
                    TTSegmentedControl(selection: $segment, options: ["Upcoming", "Past"])
                        .padding(.horizontal, 20)
                    
                    // Trip cards
                    VStack(spacing: 14) {
                        ForEach(filtered) { trip in
                            TripCard(trip: trip)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 80)
                }
            }
            .background(TTColors.bg)
            .overlay(alignment: .bottomTrailing) {
                // Floating + button (exact)
                Button {
                    // New trip action
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 56, height: 56)
                        .background(
                            Circle()
                                .fill(TTColors.accentRed)
                                .shadow(color: TTColors.accentRed.opacity(0.6), radius: 12, x: 0, y: 4)
                        )
                }
                .padding(.trailing, 24)
                .padding(.bottom, 90)
            }
        }
    }
}

struct TripCard: View {
    let trip: Trip
    
    var body: some View {
        TTCARD {
            HStack(alignment: .top, spacing: 14) {
                // Thumbnail placeholder (dark blurred map style)
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [.black, Color(red: 0.15, green: 0.15, blue: 0.18)], startPoint: .top, endPoint: .bottom))
                    .frame(width: 72, height: 72)
                    .overlay(
                        Image(systemName: "car.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(.white.opacity(0.35))
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(trip.title)
                            .font(.system(size: 18, weight: .semibold))
                        
                        Spacer()
                        
                        // Status badge
                        Text(trip.status.rawValue)
                            .font(.system(size: 11, weight: .bold))
                            .padding(.horizontal, 9)
                            .padding(.vertical, 3)
                            .background(
                                Capsule()
                                    .fill(trip.status.color.opacity(0.18))
                            )
                            .foregroundStyle(trip.status.color)
                    }
                    
                    // Distance bar
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Distance")
                            .font(.system(size: 12))
                            .foregroundStyle(TTColors.muted)
                        ProgressView(value: min(trip.distance / 250, 1.0))
                            .tint(TTColors.accentBlue)
                            .scaleEffect(x: 1, y: 1.6, anchor: .center)
                    }
                    
                    // Battery bar
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Battery Needed")
                            .font(.system(size: 12))
                            .foregroundStyle(TTColors.muted)
                        ProgressView(value: trip.batteryNeeded / 100)
                            .tint(TTColors.accentRed)
                            .scaleEffect(x: 1, y: 1.6, anchor: .center)
                    }
                    
                    if let comp = trip.checkpointsCompleted, let total = trip.totalCheckpoints {
                        Text("\(comp) of \(total) checkpoints")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(TTColors.secondaryText)
                    }
                }
            }
        }
    }
}
