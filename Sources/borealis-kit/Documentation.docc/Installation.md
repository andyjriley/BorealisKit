# Installation

Install BorealisKit in your iOS project using Swift Package Manager.

## Requirements

- iOS 15.0 or later
- Xcode 14.0 or later
- Swift 5.9 or later

## Swift Package Manager

### Adding the Package

1. In Xcode, open your project
2. Select **File** > **Add Package Dependencies...**
3. Enter the repository URL for BorealisKit
4. Choose the version or branch you want to use
5. Select your target and click **Add Package**

### Package.swift

Alternatively, add BorealisKit directly to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/borealis-kit.git", from: "1.0.0")
]
```

## Verifying Installation

After installation, verify that BorealisKit is available:

```swift
import BorealisKit

// If this compiles, installation was successful
let button = BorealisButton("Test") {}
```

## Next Steps

- Follow the <doc:GettingStarted> guide
- Explore the <doc:Components>
- Learn about the <doc:DesignSystem>
