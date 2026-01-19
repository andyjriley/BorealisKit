# Progress Indicator

Progress indicators for showing loading states and completion progress.

## Overview

The `BorealisProgressIndicator` component provides both linear and circular progress indicators with support for determinate and indeterminate states.

## Topics

### Creating a Progress Indicator

- ``BorealisProgressIndicator/init(style:variant:size:progress:)``

### Progress Styles

- ``BorealisProgressIndicator/Style/linear``
- ``BorealisProgressIndicator/Style/circular``

### Progress Variants

- ``BorealisProgressIndicator/Variant/primary``
- ``BorealisProgressIndicator/Variant/secondary``

### Progress Sizes

- ``BorealisProgressIndicator/Size/small``
- ``BorealisProgressIndicator/Size/medium``
- ``BorealisProgressIndicator/Size/large``

## Examples

### Linear Progress (Indeterminate)

```swift
BorealisProgressIndicator(style: .linear)
```

### Linear Progress (Determinate)

```swift
BorealisProgressIndicator(
    style: .linear,
    progress: 0.5  // 50% complete
)
```

### Circular Progress

```swift
BorealisProgressIndicator(
    style: .circular,
    progress: 0.75  // 75% complete
)
```

### Different Variants

```swift
BorealisProgressIndicator(
    style: .linear,
    variant: .primary
)
BorealisProgressIndicator(
    style: .linear,
    variant: .secondary
)
```

### Different Sizes

```swift
BorealisProgressIndicator(style: .linear, size: .small)
BorealisProgressIndicator(style: .linear, size: .medium)
BorealisProgressIndicator(style: .linear, size: .large)
```
