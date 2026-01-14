import SwiftUI
import BorealisKit

struct CardConcisePatternContent: View {
    let cardConciseData: [CardDataItem]
    @Binding var cardRefreshTrigger: UUID
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Single Card Example
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Single Card (Full-Width)")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Card Concise can be used by itself at full width. Hover over the card to see the blue content background appear.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let firstCard = cardConciseData.first {
                    BorealisCardConcise(cardData: firstCard)
                        .id("card-\(cardRefreshTrigger)")
                }
            }
        
        // Carousel Example (Horizontal ScrollView)
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Card Carousel")
                .font(BorealisTypography.headingM())
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Cards can be grouped in a horizontal carousel. Each card maintains its own hover state and acts as a complete link.")
                .font(BorealisTypography.body())
                .foregroundColor(BorealisColors.textSecondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(
                    rows: [GridItem(.flexible(), spacing: BorealisSpacing.xl)],
                    spacing: BorealisSpacing.xl
                ) {
                    ForEach(Array(cardConciseData.enumerated()), id: \.element.id) { index, cardData in
                        BorealisCardConcise(
                            cardData: cardData,
                            animationDelay: Double(index) * 0.2,
                            animationDuration: 0.8
                        )
                        .id("card-carousel-\(cardRefreshTrigger)-\(index)")
                        .frame(width: 320)
                    }
                }
                .padding(.horizontal, BorealisSpacing.lg)
                .padding(.vertical, BorealisSpacing.sm)
            }
        }
        
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Card Concise Features")
                    .font(BorealisTypography.headingM())
                
                Text("""
                • Image fills and crops to card dimensions
                • Teaser badge at top-left with background
                • Title and description overlay at bottom with navy background
                • Blue content background appears on hover
                • Entire card acts as a link
                • Supports UCM data structure
                • Can be used full-width or in carousels/grids
                • Default, hover, and focus states
                • Configurable height, overlay color, teaser padding
                • Entrance animations with configurable delays
                • Animation reset on disappear/refresh
                """)
                .font(BorealisTypography.body())
                .foregroundColor(BorealisColors.textSecondary)
            }
        }
        }
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var cardRefreshTrigger = UUID()
    
    let cardConciseData: [CardDataItem] = [
        CardDataItem(
            headline: AccordionHeadline(
                small: "Explore Honolulu's Island Bliss",
                large: "Explore Honolulu's Island Bliss"
            ),
            description: AccordionDescription(
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
            headline: AccordionHeadline(
                small: "Earn More Alaska Miles: Travel to 500+ Global Destinations",
                large: "Earn More Alaska Miles: Travel to 500+ Global Destinations and Convert Your Adventures into Flights, Perks, and Upgrades with Mileage Plan"
            ),
            description: AccordionDescription(
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
            CardConcisePatternContent(
                cardConciseData: cardConciseData,
                cardRefreshTrigger: $cardRefreshTrigger
            )
            .padding()
        }
        .background(BorealisColors.background)
    }
}
