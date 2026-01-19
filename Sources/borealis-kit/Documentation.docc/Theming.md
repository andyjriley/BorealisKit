# Theming

Customize your app's appearance with BorealisKit's theming system.

## Overview

BorealisKit supports multiple themes that change the color palette throughout your application. The theming system is managed through `BorealisThemeManager`.

## Topics

### Theme Manager

- ``BorealisThemeManager``
- ``BorealisThemeManager/currentTheme``

### Available Themes

- ``BorealisTheme/alaska``
- ``BorealisTheme/hawaii``

### Setting Up Theming

1. Create a theme manager instance
2. Provide it as an environment object
3. Set it on the colors system

## Examples

### Basic Setup

```swift
@main
struct MyApp: App {
    @StateObject private var themeManager = BorealisThemeManager(theme: .alaska)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeManager)
                .onAppear {
                    BorealisColors.setThemeManager(themeManager)
                }
        }
    }
}
```

### Changing Themes

```swift
struct ContentView: View {
    @EnvironmentObject var themeManager: BorealisThemeManager
    
    var body: some View {
        VStack {
            Button("Switch to Hawaii") {
                themeManager.currentTheme = .hawaii
            }
            
            Button("Switch to Alaska") {
                themeManager.currentTheme = .alaska
            }
        }
    }
}
```

### Theme-Aware Colors

All color properties in `BorealisColors` automatically update when the theme changes:

```swift
// These colors automatically reflect the current theme
BorealisColors.primary
BorealisColors.secondary
BorealisColors.background
BorealisColors.textPrimary
```

## Theme Color Palettes

### Alaska Theme

- Primary: Navy Blue (#003A8F)
- Secondary: Teal (#00A6A6)
- Accent: Sky Blue (#6EC1E4)

### Hawaii Theme

- Primary: Hawaiian Purple (#4B1E6D)
- Secondary: Hawaiian Magenta (#C81E78)
- Accent: Ocean Blue (#0079C1)
