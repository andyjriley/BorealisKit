# Getting Started with BorealisKit

Learn how to integrate and use BorealisKit in your iOS application.

## Installation

### Swift Package Manager

Add BorealisKit to your project using Swift Package Manager:

1. In Xcode, select **File** > **Add Package Dependencies...**
2. Enter the repository URL for BorealisKit
3. Select the version you want to use
4. Add the package to your target

## Basic Usage

### Import the Framework

```swift
import BorealisKit
```

### Set Up Theme Manager

The theme manager controls the color scheme for your application. Set it up in your app's entry point:

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

### Use Components

Once imported, you can use any BorealisKit component in your SwiftUI views:

```swift
struct ContentView: View {
    var body: some View {
        VStack {
            BorealisButton("Click Me", variant: .primary) {
                print("Button tapped")
            }
            
            BorealisText("Hello, World!", variant: .headingL)
        }
    }
}
```

## Next Steps

- Learn about the <doc:DesignSystem>
- Explore available <doc:Components>
- Customize your app with <doc:Theming>
