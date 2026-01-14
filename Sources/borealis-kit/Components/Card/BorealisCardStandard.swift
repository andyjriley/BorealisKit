import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Enums

/// Card Layout Type
public enum BorealisCardLayout: String {
    case `default` = "default"
    case destination = "destination"
    case price = "price"
    case flightDealOffer = "flight-deal-offer"
    case flightDealsTiles = "flight-deals-tiles"
    case customContent = "custom-content"
}

/// Image Style
public enum BorealisCardImageStyle: String {
    case cover = "cover"
    case contain = "contain"
}

/// CTA Type
public enum BorealisCardCTAType: String {
    case primary = "primary"
    case secondary = "secondary"
    case nav = "nav"
    case hyperlink = "hyperlink"
}

// MARK: - UCM Data Models

/// Card Subheadline Model (UCM)
public struct CardSubheadline {
    public let small: String
    public let large: String
    
    public init(small: String, large: String) {
        self.small = small
        self.large = large
    }
}

/// Card Fineprint Model (UCM)
public struct CardFineprint {
    public let small: String
    public let large: String
    
    public init(small: String, large: String) {
        self.small = small
        self.large = large
    }
}

/// Airport Information Model
public struct AirportInfo {
    public let code: String
    public let name: String
    public let city: String
    public let state: String
    
    public init(code: String, name: String, city: String, state: String) {
        self.code = code
        self.name = name
        self.city = city
        self.state = state
    }
}

/// Flight Deal Data Model
public struct FlightDealData {
    public let cabin: String
    public let price: String
    public let departureDate: String
    public let origin: AirportInfo
    public let destination: AirportInfo?
    
    public init(
        cabin: String,
        price: String,
        departureDate: String,
        origin: AirportInfo,
        destination: AirportInfo? = nil
    ) {
        self.cabin = cabin
        self.price = price
        self.departureDate = departureDate
        self.origin = origin
        self.destination = destination
    }
}

/// Card UCM Data Model
public struct CardUCMData: Identifiable {
    public let id: UUID
    public let headline: AccordionHeadline
    public let subheadline: CardSubheadline?
    public let description: AccordionDescription
    public let fineprint: CardFineprint?
    public let media: CardMedia?
    public let action: CardAction?
    public let flightDealData: FlightDealData?
    public let theme: [String]?
    public let data: [[String: Any]]? // JSON Generic Text Renderer data
    
    public init(
        id: UUID = UUID(),
        headline: AccordionHeadline,
        subheadline: CardSubheadline? = nil,
        description: AccordionDescription,
        fineprint: CardFineprint? = nil,
        media: CardMedia? = nil,
        action: CardAction? = nil,
        flightDealData: FlightDealData? = nil,
        theme: [String]? = nil,
        data: [[String: Any]]? = nil
    ) {
        self.id = id
        self.headline = headline
        self.subheadline = subheadline
        self.description = description
        self.fineprint = fineprint
        self.media = media
        self.action = action
        self.flightDealData = flightDealData
        self.theme = theme
        self.data = data
    }
}

// MARK: - Borealis Card Standard Component

/// Borealis Card Standard Component - Supports multiple layouts and configurations
@available(iOS 15.0, *)
public struct BorealisCardStandard: View {
    let cardData: CardDataItem
    let cardLayout: BorealisCardLayout
    let imageStyle: BorealisCardImageStyle
    let ctaType: BorealisCardCTAType
    let bordered: Bool
    let openNewWindow: Bool
    
    @State private var isHovered = false
    
    public init(
        cardData: CardDataItem,
        cardLayout: BorealisCardLayout = .default,
        imageStyle: BorealisCardImageStyle = .cover,
        ctaType: BorealisCardCTAType = .primary,
        bordered: Bool = false,
        openNewWindow: Bool = false
    ) {
        self.cardData = cardData
        self.cardLayout = cardLayout
        self.imageStyle = imageStyle
        self.ctaType = ctaType
        self.bordered = bordered
        self.openNewWindow = openNewWindow
    }
    
    public var body: some View {
        Group {
            switch cardLayout {
            case .default:
                defaultLayout
            case .destination:
                destinationLayout
            case .price:
                priceLayout
            case .flightDealOffer:
                flightDealOfferLayout
            case .flightDealsTiles:
                flightDealsTilesLayout
            case .customContent:
                customContentLayout
            }
        }
        .background(BorealisColors.surface)
        .cornerRadius(BorealisRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: BorealisRadius.lg)
                .stroke(bordered ? BorealisColors.border : Color.clear, lineWidth: 1)
        )
        .shadow(
            color: isHovered ? BorealisShadow.md.color : BorealisShadow.sm.color,
            radius: isHovered ? BorealisShadow.md.radius : BorealisShadow.sm.radius,
            x: 0,
            y: isHovered ? BorealisShadow.md.y : BorealisShadow.sm.y
        )
        .onHover { hovering in
            isHovered = hovering
        }
    }
    
    // MARK: - Layouts
    
    /// Default Layout
    private var defaultLayout: some View {
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            // Image
            if let imageUrl = cardData.media?.primary?.url,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: imageStyle == .cover ? .fill : .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    @unknown default:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    }
                }
                .cornerRadius(BorealisRadius.lg, corners: RectCorner([.topLeft, .topRight]))
            }
            
            // Content
            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                // Headline
                Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                    .font(BorealisTypography.headingM())
                    .foregroundColor(BorealisColors.textPrimary)
                
                // Description
                let descriptionText = cardData.description.large.isEmpty
                    ? cardData.description.small
                    : stripHTMLTags(from: cardData.description.large)
                Text(descriptionText)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .lineLimit(3)
                
                // CTA
                if let action = cardData.action {
                    ctaButton(action: action)
                }
            }
            .padding(BorealisSpacing.md)
        }
    }
    
    /// Destination Layout
    private var destinationLayout: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image with overlay
            if let imageUrl = cardData.media?.primary?.url,
               let url = URL(string: imageUrl) {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(BorealisColors.background)
                                .frame(height: 300)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: imageStyle == .cover ? .fill : .fit)
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .clipped()
                        case .failure:
                            Rectangle()
                                .fill(BorealisColors.background)
                                .frame(height: 300)
                        @unknown default:
                            Rectangle()
                                .fill(BorealisColors.background)
                                .frame(height: 300)
                        }
                    }
                    
                    // Overlay content
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                            .font(BorealisTypography.headingL())
                            .foregroundColor(.white)
                    }
                    .padding(BorealisSpacing.lg)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                }
                .cornerRadius(BorealisRadius.lg, corners: RectCorner([.topLeft, .topRight]))
            }
            
            // Content below image
            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                let descriptionText = cardData.description.large.isEmpty
                    ? cardData.description.small
                    : stripHTMLTags(from: cardData.description.large)
                Text(descriptionText)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                
                if let action = cardData.action {
                    ctaButton(action: action)
                }
            }
            .padding(BorealisSpacing.md)
        }
    }
    
    /// Price Layout
    private var priceLayout: some View {
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            // Image
            if let imageUrl = cardData.media?.primary?.url,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: imageStyle == .cover ? .fill : .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    @unknown default:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    }
                }
                .cornerRadius(BorealisRadius.lg, corners: RectCorner([.topLeft, .topRight]))
            }
            
            // Content
            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                    .font(BorealisTypography.headingM())
                    .foregroundColor(BorealisColors.textPrimary)
                
                let descriptionText = cardData.description.large.isEmpty
                    ? cardData.description.small
                    : stripHTMLTags(from: cardData.description.large)
                Text(descriptionText)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                
                if let action = cardData.action {
                    ctaButton(action: action)
                }
            }
            .padding(BorealisSpacing.md)
        }
    }
    
    /// Flight Deal Offer Layout
    private var flightDealOfferLayout: some View {
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            // Image
            if let imageUrl = cardData.media?.primary?.url,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: imageStyle == .cover ? .fill : .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    @unknown default:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    }
                }
                .cornerRadius(BorealisRadius.lg, corners: RectCorner([.topLeft, .topRight]))
            }
            
            // Content
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                    .font(BorealisTypography.headingM())
                    .foregroundColor(BorealisColors.textPrimary)
                
                let descriptionText = cardData.description.large.isEmpty
                    ? cardData.description.small
                    : stripHTMLTags(from: cardData.description.large)
                Text(descriptionText)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                
                if let action = cardData.action {
                    ctaButton(action: action)
                }
            }
            .padding(BorealisSpacing.md)
        }
    }
    
    /// Flight Deals Tiles Layout
    private var flightDealsTilesLayout: some View {
        VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
            // Image
            if let imageUrl = cardData.media?.primary?.url,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 150)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: imageStyle == .cover ? .fill : .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 150)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 150)
                    @unknown default:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 150)
                    }
                }
                .cornerRadius(BorealisRadius.lg, corners: RectCorner([.topLeft, .topRight]))
            }
            
            // Compact content
            VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                    .font(BorealisTypography.headingM())
                    .foregroundColor(BorealisColors.textPrimary)
                    .lineLimit(2)
                
                if let action = cardData.action {
                    ctaButton(action: action, compact: true)
                }
            }
            .padding(BorealisSpacing.sm)
        }
    }
    
    /// Custom Content Layout
    private var customContentLayout: some View {
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            // Image
            if let imageUrl = cardData.media?.primary?.url,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: imageStyle == .cover ? .fill : .fit)
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    @unknown default:
                        Rectangle()
                            .fill(BorealisColors.background)
                            .frame(height: 200)
                    }
                }
                .cornerRadius(BorealisRadius.lg, corners: RectCorner([.topLeft, .topRight]))
            }
            
            // Content
            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                    .font(BorealisTypography.headingM())
                    .foregroundColor(BorealisColors.textPrimary)
                
                let descriptionText = cardData.description.large.isEmpty
                    ? cardData.description.small
                    : stripHTMLTags(from: cardData.description.large)
                Text(descriptionText)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                
                if let action = cardData.action {
                    ctaButton(action: action)
                }
            }
            .padding(BorealisSpacing.md)
        }
    }
    
    // MARK: - CTA Button
    
    @ViewBuilder
    private func ctaButton(action: CardAction, compact: Bool = false) -> some View {
        let linkHref = action.link.href
        let linkTitle = action.link.title ?? "Learn More"
        
        switch ctaType {
        case .primary:
            Button(action: {
                handleCardAction(href: linkHref)
            }) {
                HStack(spacing: BorealisSpacing.xs) {
                    Text(linkTitle)
                    if openNewWindow {
                        Image(systemName: "arrow.up.right.square")
                            .font(.system(size: 12))
                    }
                }
            }
            .buttonStyle(BorealisButtonStyle(variant: .primary, size: compact ? .small : .medium))
            
        case .secondary:
            Button(action: {
                handleCardAction(href: linkHref)
            }) {
                HStack(spacing: BorealisSpacing.xs) {
                    Text(linkTitle)
                    if openNewWindow {
                        Image(systemName: "arrow.up.right.square")
                            .font(.system(size: 12))
                    }
                }
            }
            .buttonStyle(BorealisButtonStyle(variant: .secondary, size: compact ? .small : .medium))
            
        case .nav:
            Button(action: {
                handleCardAction(href: linkHref)
            }) {
                HStack(spacing: BorealisSpacing.xs) {
                    Text(linkTitle)
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                }
                .foregroundColor(BorealisColors.primary)
            }
            
        case .hyperlink:
            Link(destination: URL(string: linkHref) ?? URL(string: "#")!) {
                HStack(spacing: BorealisSpacing.xs) {
                    Text(linkTitle)
                        .overlay(
                            Rectangle()
                                .frame(height: 1)
                                .offset(y: 8)
                                .foregroundColor(BorealisColors.primary)
                        )
                    if openNewWindow {
                        Image(systemName: "arrow.up.right.square")
                            .font(.system(size: 12))
                    }
                }
                .foregroundColor(BorealisColors.primary)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func handleCardAction(href: String) {
        #if canImport(UIKit)
        if let url = URL(string: href), href != "#" {
            if openNewWindow {
                // Open in new window (Safari)
                UIApplication.shared.open(url, options: [.universalLinksOnly: false])
            } else {
                UIApplication.shared.open(url)
            }
        }
        #endif
    }
    
    private func stripHTMLTags(from html: String) -> String {
        let pattern = "<[^>]+>"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: html.utf16.count)
        let htmlFree = regex?.stringByReplacingMatches(in: html, options: [], range: range, withTemplate: "")
        
        let decoded = htmlFree?
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#39;", with: "'")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return decoded ?? html
    }
}

// MARK: - Button Style Helper

private struct BorealisButtonStyle: ButtonStyle {
    let variant: BorealisButton.Variant
    let size: BorealisButton.Size
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: size.fontSize, weight: .semibold))
            .foregroundColor(textColor)
            .padding(size.padding)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: BorealisRadius.md)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(BorealisRadius.md)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
    
    private var backgroundColor: Color {
        switch variant {
        case .primary:
            return BorealisColors.primary
        case .secondary, .outline, .text:
            return Color.clear
        }
    }
    
    private var textColor: Color {
        switch variant {
        case .primary:
            return .white
        case .secondary, .outline, .text:
            return BorealisColors.primary
        }
    }
    
    private var borderColor: Color {
        switch variant {
        case .secondary, .outline:
            return BorealisColors.primary
        default:
            return Color.clear
        }
    }
    
    private var borderWidth: CGFloat {
        (variant == .secondary || variant == .outline) ? 2 : 0
    }
}

// MARK: - Preview

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    let cardData: CardDataItem = CardDataItem(
        headline: AccordionHeadline(
            small: "Explore Honolulu's Island Bliss",
            large: "Explore Honolulu's Island Bliss"
        ),
        description: AccordionDescription(
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
        ScrollView {
            VStack(spacing: BorealisSpacing.lg) {
                BorealisCardStandard(
                    cardData: cardData,
                    cardLayout: .default,
                    ctaType: .primary
                )
                
                BorealisCardStandard(
                    cardData: cardData,
                    cardLayout: .destination,
                    ctaType: .secondary
                )
                
                BorealisCardStandard(
                    cardData: cardData,
                    cardLayout: .price,
                    ctaType: .hyperlink,
                    bordered: true
                )
            }
            .padding()
        }
    }
}
