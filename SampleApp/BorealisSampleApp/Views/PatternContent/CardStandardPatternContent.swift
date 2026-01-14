import SwiftUI
import BorealisKit


struct CardStandardPatternContent: View {
    
    let cardStandardData: [CardDataItem]
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Single Card Example
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Single Card (Full-Width)")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Card Standard can be used by itself at full width. Hover over the card to see the shadow effect.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let firstCard = cardStandardData.first {
                    BorealisCardStandard(cardData: firstCard)
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
                    ForEach(Array(cardStandardData.enumerated()), id: \.element.id) { index, cardData in
                        BorealisCardStandard(
                            cardData: cardData
                        )
                        .frame(width: 320)
                    }
                }
                .padding(.horizontal, BorealisSpacing.lg)
                .padding(.vertical, BorealisSpacing.sm)
            }
        }
        
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Card Standard Features")
                    .font(BorealisTypography.headingM())
                
                Text("""
                • cardLayout: Layout variant (default, destination, price, flight-deal-offer, flight-deals-tiles, custom-content)
                • imageStyle: Image style (cover, contain)
                • ctaType: CTA variant (primary, secondary, nav, hyperlink)
                • bordered: Show border around card
                • openNewWindow: Open link in new window
                • Supports UCM data structure (headline, description, media, action)
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
        )
    ]
    
    var body: some View {
        ScrollView {
            CardStandardPatternContent(cardStandardData: cardStandardData)
                .padding()
        }
        .background(BorealisColors.background)
    }
}
