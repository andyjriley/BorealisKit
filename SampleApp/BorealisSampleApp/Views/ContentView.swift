import SwiftUI
import BorealisKit

struct ContentView: View {
    @EnvironmentObject var themeManager: BorealisThemeManager
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ComponentsView()
                .tabItem {
                    Label("Components", systemImage: "square.grid.2x2")
                }
                .tag(0)
            
            CardView()
                .tabItem {
                    Label("Card", systemImage: "rectangle.stack")
                }
                .tag(1)
            
            StylesView()
                .tabItem {
                    Label("Styles", systemImage: "paintbrush")
                }
                .tag(2)
            
            PatternsView()
                .tabItem {
                    Label("Patterns", systemImage: "puzzlepiece")
                }
                .tag(3)
        }
    }
}

#Preview {
    ContentView()
}
