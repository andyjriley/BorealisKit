# BorealisKit - iOS Component Library

BorealisKit is an iOS framework that brings the UCM (User Component Model) Patterns from the Borealis Component Library to native iOS applications. Built with SwiftUI, it provides a comprehensive set of reusable UI components following modern design principles.

## Features

- 🎨 **Design System**: Consistent colors, typography, spacing, corner radius, and shadows
- 🧩 **UCM Patterns**: Reusable component patterns for common UI scenarios
- 📱 **Native iOS**: Built with SwiftUI for optimal performance
- ♿ **Accessible**: Components designed with accessibility in mind

## Components

### Core Components

- **BorealisButton**: Multiple variants (primary, secondary, outline, text) and sizes (small, medium, large)
- **BorealisInput**: Text input with validation, error states, and helper text
- **BorealisCard**: Container component with customizable padding and shadows
- **BorealisCardConcise**: Concise card component with image, text overlay, and hover effects
- **BorealisCardStandard**: Standard card component with multiple layouts (default, destination, price, flight-deal-offer, flight-deals-tiles, custom-content)
- **BorealisAlert**: Alert messages with different types (default, success, warning, error, info/information) and support for HTML content, action links, and custom JSON RTE data
- **BorealisAccordion**: Expandable and collapsible content sections with multiple variants, sizes, and customization options
- **BorealisAccordionGroup**: Group of accordions with single or multiple expansion modes

### Design System

- **BorealisColors**: Color palette with semantic naming (primary, secondary, semantic, neutral colors)
- **BorealisTypography**: Typography scale and text styles (headingXL, headingL, headingM, body, bodySmall, caption)
- **BorealisSpacing**: Consistent spacing system (xs, sm, md, lg, xl, xxl)
- **BorealisRadius**: Corner radius values (none, sm, md, lg, xl, full)
- **BorealisShadow**: Shadow definitions (sm, md, lg)

## Installation

### Swift Package Manager

Add BorealisKit to your project using Swift Package Manager:

1. In Xcode, go to **File** > **Add Packages...**
2. Enter the repository URL or add the local path
3. Select the version and add to your target

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(path: "../borealis-kit")
]
```

## Usage

### Basic Example

```swift
import SwiftUI
import BorealisKit

struct MyView: View {
    @State private var text = ""
    
    var body: some View {
        VStack(spacing: BorealisSpacing.md) {
            BorealisButton("Click Me", variant: .primary) {
                // Handle action
            }
            
            BorealisInput(
                title: "Email",
                placeholder: "Enter email",
                text: $text
            )
        }
        .padding()
    }
}
```

### Card Example

```swift
struct MyView: View {
    let cardData = CardDataItem(
        headline: AccordionHeadline(
            small: "Card Title",
            large: "Card Title"
        ),
        description: AccordionDescription(
            small: "Card description",
            large: "Card description"
        ),
        media: CardMedia(
            primary: CardMediaItem(
                url: "https://example.com/image.jpg",
                description: "Image description"
            )
        ),
        action: CardAction(
            link: CardLink(
                href: "https://example.com",
                title: "Learn More"
            )
        )
    )
    
    var body: some View {
        BorealisCardStandard(
            cardData: cardData,
            cardLayout: .default,
            ctaType: .primary
        )
    }
}
```

### Alert Example

```swift
struct MyView: View {
    var body: some View {
        BorealisAlert(
            type: .success,
            description: "Your changes have been saved successfully.",
            action: AlertAction(
                link: AlertLink(
                    href: "https://example.com",
                    title: "Learn More"
                )
            )
        )
    }
}
```

## Sample App

The project includes a comprehensive sample app demonstrating all components and UCM patterns. To run the sample app:

1. Open the `SampleApp` folder in Xcode
2. Add the BorealisKit package as a local dependency
3. Build and run on a simulator or device

The sample app includes:
- **Components Tab**: Showcase of all individual components with all variants and sizes
- **Card Tab**: Interactive card component with configuration options
- **Styles Tab**: Design system showcase with colors, typography, spacing, radius, and shadows
- **Patterns Tab**: Common UCM pattern combinations (Alert, Accordion, Accordion Group, Card Concise, Card Standard)

## UCM Patterns

The framework focuses on implementing UCM (User Component Model) Patterns, which are reusable component combinations for common UI scenarios:

1. **Alert Pattern**: Providing feedback and important information to users with different alert types
2. **Accordion Pattern**: Expandable and collapsible content sections
3. **Accordion Group Pattern**: Multiple accordion items with shared behavior (single or multiple expansion)
4. **Card Concise Pattern**: Concise cards with image, text overlay, and hover effects
5. **Card Standard Pattern**: Standard cards with multiple layouts and configurations

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.9+

## Thread Safety

This framework is designed with thread safety in mind. All components are SwiftUI views that are inherently thread-safe when used within the main thread context. When integrating with Core Data or other thread-sensitive APIs, ensure proper context management.

## Contributing

Contributions are welcome! Please ensure that:
- Code follows Swift style guidelines
- Components maintain consistency with the design system
- Thread safety is considered for any Core Data integrations
- Tests are included for new components

## Acknowledgments

Based on the Borealis Component Library web implementation, adapted for native iOS development.
