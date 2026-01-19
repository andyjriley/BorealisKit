# Shadows

The shadow system for BorealisKit.

## Overview

`BorealisShadow` provides consistent shadow styles for elevation and depth throughout your application.

## Topics

### Shadow Styles

- ``BorealisShadow/sm`` - Small shadow
- ``BorealisShadow/md`` - Medium shadow
- ``BorealisShadow/lg`` - Large shadow

### Shadow Properties

- ``BorealisShadow/Shadow/color``
- ``BorealisShadow/Shadow/radius``
- ``BorealisShadow/Shadow/x``
- ``BorealisShadow/Shadow/y``

## Examples

### Using Shadows

```swift
// Card shadow
Card()
    .shadow(
        color: BorealisShadow.sm.color,
        radius: BorealisShadow.sm.radius,
        x: 0,
        y: BorealisShadow.sm.y
    )

// Button shadow
Button("Click Me") {}
    .shadow(
        color: BorealisShadow.md.color,
        radius: BorealisShadow.md.radius,
        x: 0,
        y: BorealisShadow.md.y
    )
```
