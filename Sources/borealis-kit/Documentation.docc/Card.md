# Card

Card components for displaying content in structured containers.

## Overview

BorealisKit provides three card components:
- `BorealisCard`: A generic card container with customizable content
- `BorealisCardStandard`: A standard card with headline, description, media, and action
- `BorealisCardConcise`: A compact card variant

## Topics

### Card Components

- ``BorealisCard``
- ``BorealisCardStandard``
- ``BorealisCardConcise``

### Card Models

- ``Headline``
- ``Description``
- ``CardDataItem``
- ``CardMedia``
- ``CardAction``

### Card Layouts

- ``BorealisCardLayout/default``
- ``BorealisCardLayout/destination``
- ``BorealisCardLayout/price``
- ``BorealisCardLayout/flightDealOffer``
- ``BorealisCardLayout/flightDealsTiles``
- ``BorealisCardLayout/customContent``

## Examples

### Generic Card

```swift
BorealisCard {
    VStack(alignment: .leading) {
        Text("Card Title")
            .font(BorealisTypography.headingM())
        Text("Card content goes here")
            .font(BorealisTypography.body())
    }
}
```

### Standard Card

```swift
let cardData = CardDataItem(
    headline: Headline(
        small: "Card Title",
        large: "Card Title"
    ),
    description: Description(
        small: "Card description",
        large: "Card description"
    ),
    media: CardMedia(
        primary: CardMediaItem(
            url: "https://example.com/image.jpg",
            description: "Image description"
        )
    ),
    action: CardAction(
        link: CardLink(
            href: "https://example.com",
            title: "Learn More"
        )
    )
)

BorealisCardStandard(
    cardData: cardData,
    cardLayout: .default,
    imageStyle: .cover,
    ctaType: .primary
)
```

### Concise Card

```swift
BorealisCardConcise(
    cardData: cardData,
    imageStyle: .cover,
    ctaType: .primary
)
```
