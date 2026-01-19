# Spacing

The spacing system for BorealisKit.

## Overview

`BorealisSpacing` provides a consistent set of spacing values for padding, margins, and gaps throughout your application.

## Topics

### Spacing Values

- ``BorealisSpacing/xs`` - Extra small spacing (4pt)
- ``BorealisSpacing/sm`` - Small spacing (8pt)
- ``BorealisSpacing/md`` - Medium spacing (16pt)
- ``BorealisSpacing/lg`` - Large spacing (24pt)
- ``BorealisSpacing/xl`` - Extra large spacing (32pt)

## Examples

### Using Spacing

```swift
// Padding
VStack {
    Text("Content")
}
.padding(BorealisSpacing.md)

// Custom padding
VStack {
    Text("Content")
}
.padding(.horizontal, BorealisSpacing.lg)
.padding(.vertical, BorealisSpacing.md)

// Spacing between elements
VStack(spacing: BorealisSpacing.sm) {
    Text("Item 1")
    Text("Item 2")
    Text("Item 3")
}

// Margins
HStack {
    Text("Left")
    Spacer()
    Text("Right")
}
.padding(.horizontal, BorealisSpacing.md)
```
