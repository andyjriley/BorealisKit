# Chip

Interactive chip components for tags, labels, and selections.

## Overview

The `BorealisChip` component provides a flexible way to display tags, labels, or selectable items with support for icons, removal actions, and different visual states.

## Topics

### Creating a Chip

- ``BorealisChip/init(_:variant:size:leadingIcon:trailingIcon:showRemoveButton:onTap:onRemove:)``

### Chip Variants

- ``BorealisChip/Variant/defaultStyle``
- ``BorealisChip/Variant/selected``
- ``BorealisChip/Variant/disabled``

### Chip Sizes

- ``BorealisChip/Size/small``
- ``BorealisChip/Size/medium``
- ``BorealisChip/Size/large``

## Examples

### Basic Chip

```swift
BorealisChip("Tag")
```

### Selected Chip

```swift
BorealisChip("Selected", variant: .selected)
```

### Chip with Icons

```swift
BorealisChip("Favorite", leadingIcon: "star.fill")
BorealisChip("Next", trailingIcon: "chevron.right")
```

### Removable Chip

```swift
BorealisChip(
    "Removable",
    showRemoveButton: true,
    onRemove: {
        // Handle removal
    }
)
```

### Interactive Chip

```swift
BorealisChip(
    "Tap Me",
    onTap: {
        print("Chip tapped")
    }
)
```

### Different Sizes

```swift
BorealisChip("Small", size: .small)
BorealisChip("Medium", size: .medium)
BorealisChip("Large", size: .large)
```
