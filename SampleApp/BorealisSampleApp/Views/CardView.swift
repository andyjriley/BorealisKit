import SwiftUI
import BorealisKit

struct CardView: View {
    // Card Configuration
    @State private var imageStyle: BorealisCardImageStyle = .cover
    @State private var ctaType: BorealisCardCTAType = .primary
    @State private var bordered = false
    @State private var openNewWindow = false
    
    // Static card data
    let cardData: CardDataItem = CardDataItem(
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
                description: "This is image alt"
            )
        ),
        action: CardAction(
            link: CardLink(
                href: "https://vacations.alaskaair.com",
                title: "Visit Honolulu"
            )
        )
    )
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: BorealisSpacing.xl) {
                    // Card Display
                    VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                        Text("Card Preview")
                            .font(BorealisTypography.headingL())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        BorealisCardStandard(
                            cardData: cardData,
                            cardLayout: .default,
                            imageStyle: imageStyle,
                            ctaType: ctaType,
                            bordered: bordered,
                            openNewWindow: openNewWindow
                        )
                    }
                    
                    // Configuration Controls
                    BorealisCard {
                        VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
                            Text("Card Configuration")
                                .font(BorealisTypography.headingM())
                            
                            // Image Style
                            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                                Text("Image Style")
                                    .font(BorealisTypography.body())
                                    .fontWeight(.semibold)
                                
                                Picker("Image Style", selection: $imageStyle) {
                                    Text("Cover").tag(BorealisCardImageStyle.cover)
                                    Text("Contain").tag(BorealisCardImageStyle.contain)
                                }
                                .pickerStyle(.segmented)
                            }
                            
                            // CTA Type
                            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                                Text("CTA Type")
                                    .font(BorealisTypography.body())
                                    .fontWeight(.semibold)
                                
                                Picker("CTA Type", selection: $ctaType) {
                                    Text("Primary").tag(BorealisCardCTAType.primary)
                                    Text("Secondary").tag(BorealisCardCTAType.secondary)
                                    Text("Nav").tag(BorealisCardCTAType.nav)
                                    Text("Hyperlink").tag(BorealisCardCTAType.hyperlink)
                                }
                                .pickerStyle(.segmented)
                            }
                            
                            Divider()
                            
                            // Toggles
                            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                                Toggle("Bordered", isOn: $bordered)
                                    .font(BorealisTypography.body())
                                
                                Toggle("Open New Window", isOn: $openNewWindow)
                                    .font(BorealisTypography.body())
                            }
                        }
                    }
                }
                .padding(BorealisSpacing.lg)
            }
            .navigationTitle("Card")
            .background(BorealisColors.background)
        }
    }
}
