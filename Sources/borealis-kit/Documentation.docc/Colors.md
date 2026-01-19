# Colors

The color system for BorealisKit.

## Overview

`BorealisColors` provides a comprehensive color palette that automatically adapts to the current theme. Colors are theme-aware and update when the theme changes.

## Topics

### Primary Colors

- ``BorealisColors/primary``
- ``BorealisColors/primaryDark``
- ``BorealisColors/primaryLight``
- ``BorealisColors/primaryText``

### Secondary Colors

- ``BorealisColors/secondary``
- ``BorealisColors/secondaryDark``
- ``BorealisColors/secondaryLight``

### Semantic Colors

- ``BorealisColors/success``
- ``BorealisColors/warning``
- ``BorealisColors/error``
- ``BorealisColors/info``

### Neutral Colors

- ``BorealisColors/background``
- ``BorealisColors/surface``
- ``BorealisColors/textPrimary``
- ``BorealisColors/textSecondary``
- ``BorealisColors/border``

## Examples

### Using Colors

```swift
// Primary colors
Text("Primary Text")
    .foregroundColor(BorealisColors.primary)

Rectangle()
    .fill(BorealisColors.primaryLight)

// Semantic colors
Text("Success")
    .foregroundColor(BorealisColors.success)

Text("Error")
    .foregroundColor(BorealisColors.error)

// Neutral colors
VStack {
    Text("Content")
}
.background(BorealisColors.background)

Card()
    .background(BorealisColors.surface)
```

### Theme-Aware Colors

Colors automatically update when the theme changes:

```swift
// These colors change based on the current theme
BorealisColors.primary  // Navy for Alaska, Purple for Hawaii
BorealisColors.secondary  // Teal for Alaska, Magenta for Hawaii
```
