# Design System

The foundational design tokens and utilities that power BorealisKit components.

## Overview

The BorealisKit design system provides a comprehensive set of design tokens including colors, typography, spacing, radius, and shadows that ensure consistency across all components.

## Topics

### Colors

- <doc:Colors>
- ``BorealisColors``

### Typography

- <doc:Typography>
- ``BorealisTypography``

### Spacing

- <doc:Spacing>
- ``BorealisSpacing``

### Radius

- <doc:Radius>
- ``BorealisRadius``

### Shadows

- <doc:Shadows>
- ``BorealisShadow``

### Theming

- <doc:Theming>
- ``BorealisTheme``

## Design Tokens

All design tokens are accessible as static properties and automatically adapt to the current theme:

```swift
// Colors
BorealisColors.primary
BorealisColors.secondary
BorealisColors.background
BorealisColors.surface
BorealisColors.textPrimary
BorealisColors.textSecondary

// Typography
BorealisTypography.headingXL()
BorealisTypography.headingL()
BorealisTypography.body()
BorealisTypography.bodySmall()

// Spacing
BorealisSpacing.xs
BorealisSpacing.sm
BorealisSpacing.md
BorealisSpacing.lg
BorealisSpacing.xl

// Radius
BorealisRadius.sm
BorealisRadius.md
BorealisRadius.lg

// Shadows
BorealisShadow.sm
BorealisShadow.md
BorealisShadow.lg
```
