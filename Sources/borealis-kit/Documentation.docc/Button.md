# Button

A versatile button component with multiple variants and sizes.

## Overview

The `BorealisButton` component provides a consistent button interface with support for different visual styles (primary, secondary, outline, text) and sizes (small, medium, large).

## Topics

### Creating a Button

- ``BorealisButton/init(_:variant:size:action:)``

### Button Variants

- ``BorealisButton/Variant/primary``
- ``BorealisButton/Variant/secondary``
- ``BorealisButton/Variant/outline``
- ``BorealisButton/Variant/text``

### Button Sizes

- ``BorealisButton/Size/small``
- ``BorealisButton/Size/medium``
- ``BorealisButton/Size/large``

## Examples

### Primary Button

```swift
BorealisButton("Submit", variant: .primary) {
    // Handle button tap
}
```

### Secondary Button

```swift
BorealisButton("Cancel", variant: .secondary) {
    // Handle button tap
}
```

### Outline Button

```swift
BorealisButton("Learn More", variant: .outline) {
    // Handle button tap
}
```

### Text Button

```swift
BorealisButton("Skip", variant: .text) {
    // Handle button tap
}
```

### Different Sizes

```swift
BorealisButton("Small", variant: .primary, size: .small) {}
BorealisButton("Medium", variant: .primary, size: .medium) {}
BorealisButton("Large", variant: .primary, size: .large) {}
```
