# Radius

The border radius system for BorealisKit.

## Overview

`BorealisRadius` provides consistent corner radius values for rounded corners throughout your application.

## Topics

### Radius Values

- ``BorealisRadius/sm`` - Small radius (4pt)
- ``BorealisRadius/md`` - Medium radius (8pt)
- ``BorealisRadius/lg`` - Large radius (12pt)

## Examples

### Using Radius

```swift
// Card corners
RoundedRectangle(cornerRadius: BorealisRadius.lg)
    .fill(BorealisColors.surface)

// Button corners
Button("Click Me") {}
    .padding()
    .background(BorealisColors.primary)
    .cornerRadius(BorealisRadius.md)

// Chip corners
Text("Tag")
    .padding()
    .background(BorealisColors.surface)
    .cornerRadius(BorealisRadius.sm)
```
