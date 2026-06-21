import SwiftUI

enum Tab: String, CaseIterable {
    case map = "MAP"
    case trips = "TRIPS"
    case explore = "EXPLORE"
    case profile = "PROFILE"
    
    var icon: String {
        switch self {
        case .map: return "location.fill"
        case .trips: return "folder.fill"
        case .explore: return "safari.fill"
        case .profile: return "person.fill"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .map
    @StateObject private var userStore = UserStore()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content
            Group {
                switch selectedTab {
                case .map:
                    MapHomeView(user: userStore.user)
                case .trips:
                    TripsView()
                case .explore:
                    ExploreView(user: userStore.user)
                case .profile:
                    ProfileView(user: $userStore.user)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(TTColors.bg.ignoresSafeArea())
            
            // Custom bottom tab bar (exact style)
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            // Match the exact dark neon tab bar
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.black.opacity(0.92))
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                VStack(spacing: 4) {
                    Image(systemName: tab.icon)
                        .font(.system(size: 20, weight: selectedTab == tab ? .bold : .regular))
                    Text(tab.rawValue)
                        .font(.system(size: 10, weight: .semibold))
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(selectedTab == tab ? TTColors.accentBlue : TTColors.muted)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3)) {
                        selectedTab = tab
                    }
                }
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 28)
        .background(
            Rectangle()
                .fill(Color.black.opacity(0.92))
                .overlay(
                    Rectangle()
                        .fill(Color.white.opacity(0.06))
                        .frame(height: 0.5),
                    alignment: .top
                )
        )
    }
}

// Simple observable store for demo state
class UserStore: ObservableObject {
    @Published var user = User.demo
}
