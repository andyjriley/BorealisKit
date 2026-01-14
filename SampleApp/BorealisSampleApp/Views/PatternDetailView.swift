import SwiftUI
import BorealisKit

// Pattern Detail View
struct PatternDetailView: View {
    let patternType: PatternType

    @State private var cardRefreshTrigger = UUID()
    @State private var accordionExpanded1 = false
    @State private var accordionExpanded2 = false
    @State private var accordionExpanded3 = false
    @State private var accordionExpanded4 = false
    @State private var accordionExpanded5 = false
    @State private var accordionExpanded6 = false
    
    let accordionItems = [
        AccordionItem(title: "Getting Started"),
        AccordionItem(title: "Components"),
        AccordionItem(title: "Design System")
    ]
    
    // Card Standard Data Examples
    let cardStandardData: [CardDataItem] = [
        CardDataItem(
            headline: Headline(
                small: "Explore Honolulu's Island Bliss",
                large: "Explore Honolulu's Island Bliss"
            ),
            description: Description(
                small: "Immerse yourself in Honolulu's stunning beaches, rich Hawaiian culture, and breathtaking natural beauty for an unforgettable island adventure. 🌺",
                large: "<html><p>Immerse yourself in Honolulu's stunning beaches, rich Hawaiian culture, and breathtaking natural beauty for an <strong>unforgettable</strong> island adventure. 🌺</p></html>"
            ),
            media: CardMedia(
                primary: CardMediaItem(
                    url: "https://images.contentstack.io/v3/assets/blt2cefe12c88e9dd91/blte809e81b0efe6db8/66d0ad9723cce70a04d5f656/honolulu.webp",
                    description: "Honolulu beach scene"
                )
            ),
            action: CardAction(
                link: CardLink(
                    href: "https://vacations.alaskaair.com",
                    title: "Visit Honolulu"
                )
            )
        ),
        CardDataItem(
            headline: Headline(
                small: "Earn More Alaska Miles: Travel to 500+ Global Destinations",
                large: "Earn More Alaska Miles: Travel to 500+ Global Destinations and Convert Your Adventures into Flights, Perks, and Upgrades with Mileage Plan"
            ),
            description: Description(
                small: "Discover amazing destinations worldwide and earn miles with every trip. Your adventures can become flights, perks, and upgrades.",
                large: "<html><p>Discover amazing destinations worldwide and earn miles with every trip. Your adventures can become flights, perks, and upgrades.</p></html>"
            ),
            media: CardMedia(
                primary: CardMediaItem(
                    url: "https://images.contentstack.io/v3/assets/blt2cefe12c88e9dd91/blte809e81b0efe6db8/66d0ad9723cce70a04d5f656/honolulu.webp",
                    description: "Travel destinations"
                )
            ),
            action: CardAction(
                link: CardLink(
                    href: "#",
                    title: "Learn more"
                )
            )
        )
    ]
    
    // Card Concise Data Examples
    let cardConciseData: [CardDataItem] = [
        CardDataItem(
            headline: Headline(
                small: "Explore Honolulu's Island Bliss",
                large: "Explore Honolulu's Island Bliss"
            ),
            description: Description(
                small: "Immerse yourself in Honolulu's stunning beaches, rich Hawaiian culture, and breathtaking natural beauty for an unforgettable island adventure. 🌺",
                large: "<html><p>Immerse yourself in Honolulu's stunning beaches, rich Hawaiian culture, and breathtaking natural beauty for an <strong>unforgettable</strong> island adventure. 🌺</p></html>"
            ),
            teaser: CardTeaser(headline: "Limited time only"),
            media: CardMedia(
                primary: CardMediaItem(
                    url: "https://images.contentstack.io/v3/assets/blt2cefe12c88e9dd91/blte809e81b0efe6db8/66d0ad9723cce70a04d5f656/honolulu.webp",
                    description: "Honolulu beach scene"
                )
            ),
            action: CardAction(
                link: CardLink(
                    href: "https://vacations.alaskaair.com",
                    title: "Let's go to Honolulu"
                )
            )
        ),
        CardDataItem(
            headline: Headline(
                small: "Earn More Alaska Miles: Travel to 500+ Global Destinations",
                large: "Earn More Alaska Miles: Travel to 500+ Global Destinations and Convert Your Adventures into Flights, Perks, and Upgrades with Mileage Plan"
            ),
            description: Description(
                small: "Discover amazing destinations worldwide and earn miles with every trip. Your adventures can become flights, perks, and upgrades.",
                large: "<html><p>Discover amazing destinations worldwide and earn miles with every trip. Your adventures can become flights, perks, and upgrades.</p></html>"
            ),
            media: CardMedia(
                primary: CardMediaItem(
                    url: "https://images.contentstack.io/v3/assets/blt2cefe12c88e9dd91/blte809e81b0efe6db8/66d0ad9723cce70a04d5f656/honolulu.webp",
                    description: "Travel destinations"
                )
            ),
            action: CardAction(
                link: CardLink(
                    href: "#",
                    title: "Learn more"
                )
            )
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: BorealisSpacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text(patternType.rawValue)
                        .font(BorealisTypography.headingXL())
                    
                    Text(patternType.description)
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Pattern Content
                patternContent
            }
            .padding(BorealisSpacing.lg)
        }
        .navigationTitle(patternType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .background(BorealisColors.background)
        .toolbar {
            if patternType == .cardConcise {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        cardRefreshTrigger = UUID() // Trigger refresh
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .foregroundColor(BorealisColors.primary)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var patternContent: some View {
        switch patternType {
        case .accordion:
            AccordionPatternContent(
                accordionExpanded1: $accordionExpanded1,
                accordionExpanded2: $accordionExpanded2,
                accordionExpanded3: $accordionExpanded3,
                accordionExpanded4: $accordionExpanded4,
                accordionExpanded5: $accordionExpanded5,
                accordionExpanded6: $accordionExpanded6
            )
        case .accordionGroup:
            AccordionGroupPatternContent(
                accordionItems: accordionItems
            )
        case .alert:
            AlertPatternContent()
        case .cardConcise:
            CardConcisePatternContent(
                cardConciseData: cardConciseData,
                cardRefreshTrigger: $cardRefreshTrigger
            )
        case .cardStandard:
            CardStandardPatternContent(cardStandardData: cardStandardData)
        }
    }
}
