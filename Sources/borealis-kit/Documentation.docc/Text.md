# Text

A styled text component with typography variants and color options.

## Overview

The `BorealisText` component provides consistent typography styling with support for different text styles (headings, body, caption) and color variants.

## Topics

### Creating Text

- ``BorealisText/init(_:variant:weight:colorVariant:alignment:)``

### Text Variants

- ``BorealisText/Variant/headingXL``
- ``BorealisText/Variant/headingL``
- ``BorealisText/Variant/headingM``
- ``BorealisText/Variant/body``
- ``BorealisText/Variant/bodySmall``
- ``BorealisText/Variant/caption``

### Color Variants

- ``BorealisText/ColorVariant/primary``
- ``BorealisText/ColorVariant/secondary``
- ``BorealisText/ColorVariant/muted``
- ``BorealisText/ColorVariant/inverse``
- ``BorealisText/ColorVariant/success``
- ``BorealisText/ColorVariant/warning``
- ``BorealisText/ColorVariant/error``
- ``BorealisText/ColorVariant/info``
- ``BorealisText/ColorVariant/custom(_:)``

## Examples

### Headings

```swift
BorealisText("Main Title", variant: .headingXL)
BorealisText("Section Title", variant: .headingL)
BorealisText("Subsection", variant: .headingM)
```

### Body Text

```swift
BorealisText("Regular body text", variant: .body)
BorealisText("Small body text", variant: .bodySmall)
BorealisText("Caption text", variant: .caption)
```

### Color Variants

```swift
BorealisText("Primary text", colorVariant: .primary)
BorealisText("Secondary text", colorVariant: .secondary)
BorealisText("Success message", colorVariant: .success)
BorealisText("Error message", colorVariant: .error)
```

### Custom Styling

```swift
BorealisText(
    "Custom text",
    variant: .body,
    weight: .semibold,
    colorVariant: .custom(.blue),
    alignment: .center
)
```
