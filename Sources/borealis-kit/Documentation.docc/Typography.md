# Typography

The typography system for BorealisKit.

## Overview

`BorealisTypography` provides a consistent set of font styles and sizes that follow the Borealis design system.

## Topics

### Font Sizes

- ``BorealisTypography/fontSizeXS``
- ``BorealisTypography/fontSizeS``
- ``BorealisTypography/fontSizeM``
- ``BorealisTypography/fontSizeL``
- ``BorealisTypography/fontSizeXL``
- ``BorealisTypography/fontSizeXXL``

### Font Styles

- ``BorealisTypography/headingXL()``
- ``BorealisTypography/headingL()``
- ``BorealisTypography/headingM()``
- ``BorealisTypography/body()``
- ``BorealisTypography/bodySmall()``
- ``BorealisTypography/caption()``

## Examples

### Using Typography

```swift
// Headings
Text("Extra Large Heading")
    .font(BorealisTypography.headingXL())

Text("Large Heading")
    .font(BorealisTypography.headingL())

Text("Medium Heading")
    .font(BorealisTypography.headingM())

// Body text
Text("Body text")
    .font(BorealisTypography.body())

Text("Small body text")
    .font(BorealisTypography.bodySmall())

// Caption
Text("Caption text")
    .font(BorealisTypography.caption())
```

### Custom Font Sizes

```swift
Text("Custom size")
    .font(.system(size: BorealisTypography.fontSizeM))
```
