import SwiftUI

@main
struct TeslaTrekApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .background(TTColors.bg.ignoresSafeArea())
        }
    }
}
