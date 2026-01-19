import SwiftUI
import BorealisKit

@main
struct BorealisSampleAppApp: App {
    @StateObject private var themeManager = BorealisThemeManager(theme: .alaska)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .onAppear {
                    // Set the shared theme manager for BorealisColors
                    BorealisColors.setThemeManager(themeManager)
                }
                .onChange(of: themeManager.currentTheme) { _ in
                    // Update shared theme manager when theme changes
                    BorealisColors.setThemeManager(themeManager)
                }
        }
    }
}
