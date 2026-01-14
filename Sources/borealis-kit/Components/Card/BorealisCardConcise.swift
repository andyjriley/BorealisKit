import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Card Media Model (UCM)
public struct CardMedia {
    public let primary: CardMediaItem?
    
    public init(primary: CardMediaItem?) {
        self.primary = primary
    }
}

/// Card Media Item Model (UCM)
public struct CardMediaItem {
    public let url: String
    public let description: String?
    
    public init(url: String, description: String? = nil) {
        self.url = url
        self.description = description
    }
}

/// Card Action Model (UCM)
public struct CardAction {
    public let link: CardLink
    
    public init(link: CardLink) {
        self.link = link
    }
}

/// Card Link Model (UCM)
public struct CardLink {
    public let href: String
    public let title: String?
    
    public init(href: String, title: String? = nil) {
        self.href = href
        self.title = title
    }
}

/// Card Teaser Model (UCM)
public struct CardTeaser {
    public let headline: String?
    
    public init(headline: String?) {
        self.headline = headline
    }
}

/// Card Data Model for UCM (Universal Content Model)
public struct CardDataItem: Identifiable {
    public let id: UUID
    public let headline: Headline
    public let description: Description
    public let teaser: CardTeaser?
    public let media: CardMedia?
    public let action: CardAction?
    
    public init(
        id: UUID = UUID(),
        headline: Headline,
        description: Description,
        teaser: CardTeaser? = nil,
        media: CardMedia? = nil,
        action: CardAction? = nil
    ) {
        self.id = id
        self.headline = headline
        self.description = description
        self.teaser = teaser
        self.media = media
        self.action = action
    }
    
    // Convenience initializer from dictionary (for JSON parsing)
    public init?(from dictionary: [String: Any]) {
        guard let headlineDict = dictionary["headline"] as? [String: Any],
              let descriptionDict = dictionary["description"] as? [String: Any],
              let headlineSmall = headlineDict["small"] as? String,
              let descSmall = descriptionDict["small"] as? String else {
            return nil
        }
        
        let headlineLarge = headlineDict["large"] as? String ?? headlineSmall
        let descLarge = descriptionDict["small"] as? String ?? descSmall
        
        self.id = UUID()
        self.headline = Headline(small: headlineSmall, large: headlineLarge)
        self.description = Description(small: descSmall, large: descLarge)
        
        // Parse teaser
        if let teaserDict = dictionary["teaser"] as? [String: Any] {
            self.teaser = CardTeaser(headline: teaserDict["headline"] as? String)
        } else {
            self.teaser = nil
        }
        
        // Parse media
        if let mediaDict = dictionary["media"] as? [String: Any],
           let primaryDict = mediaDict["primary"] as? [String: Any],
           let url = primaryDict["url"] as? String {
            self.media = CardMedia(
                primary: CardMediaItem(
                    url: url,
                    description: primaryDict["description"] as? String
                )
            )
        } else {
            self.media = nil
        }
        
        // Parse action
        if let actionDict = dictionary["action"] as? [String: Any],
           let linkDict = actionDict["link"] as? [String: Any],
           let href = linkDict["href"] as? String {
            self.action = CardAction(
                link: CardLink(
                    href: href.isEmpty ? "#" : href,
                    title: linkDict["title"] as? String
                )
            )
        } else {
            self.action = CardAction(link: CardLink(href: "#", title: nil))
        }
    }
}

/// Borealis Card Concise Component - UCM Pattern
@available(iOS 15.0, *)
public struct BorealisCardConcise: View {
    let cardData: CardDataItem
    let animationDelay: Double
    let animationDuration: Double
    let cardHeight: CGFloat
    let overlayBackgroundColor: Color
    let teaserPadding: CGFloat
    @State private var isHovered = false
    @State private var isVisible = false
    @State private var animationTrigger = UUID()
    
    public init(
        cardData: CardDataItem,
        animationDelay: Double = 0.0,
        animationDuration: Double = 0.8,
        cardHeight: CGFloat = 250,
        overlayBackgroundColor: Color? = nil,
        teaserPadding: CGFloat = BorealisSpacing.md
    ) {
        self.cardData = cardData
        self.animationDelay = animationDelay
        self.animationDuration = animationDuration
        self.cardHeight = cardHeight
        self.overlayBackgroundColor = overlayBackgroundColor ?? Color(red: 0.0, green: 0.1, blue: 0.2) // Navy blue
        self.teaserPadding = teaserPadding
    }
    
    public var body: some View {
        let linkHref = cardData.action?.link.href ?? "#"
        
        Button(action: {
            handleCardTap(href: linkHref)
        }) {
            ZStack {
                // Image
                if let imageUrl = cardData.media?.primary?.url,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(BorealisColors.background)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: cardHeight)
                        case .failure:
                            Rectangle()
                                .fill(BorealisColors.background)
                        @unknown default:
                            Rectangle()
                                .fill(BorealisColors.background)
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: cardHeight, maxHeight: cardHeight)
                    .clipped()
                    .offset(x: isVisible ? 0 : -50)
                    .opacity(isVisible ? 1 : 0)
                    .animation(
                        .easeOut(duration: animationDuration)
                        .delay(animationDelay),
                        value: isVisible
                    )
                } else {
                    Rectangle()
                        .fill(BorealisColors.background)
                        .frame(maxWidth: .infinity)
                        .frame(height: cardHeight)
                        .offset(x: isVisible ? 0 : -50)
                        .opacity(isVisible ? 1 : 0)
                        .animation(
                            .easeOut(duration: animationDuration)
                            .delay(animationDelay),
                            value: isVisible
                        )
                }
                
                // Teaser badge (top-left, overlays image with background)
                if let teaserHeadline = cardData.teaser?.headline {
                    VStack {
                        HStack {
                            Text(teaserHeadline)
                                .font(BorealisTypography.bodySmall())
                                .foregroundColor(.black)
                                .padding(.horizontal, BorealisSpacing.md)
                                .padding(.vertical, BorealisSpacing.xs)
                                .background(
                                    Capsule()
                                        .fill(Color.white.opacity(0.9))
                                )
                                .offset(x: isVisible ? 0 : -30)
                                .opacity(isVisible ? 1 : 0)
                                .animation(
                                    .easeOut(duration: animationDuration)
                                    .delay(animationDelay + 0.1),
                                    value: isVisible
                                )
                            Spacer()
                        }
                        Spacer()
                    }
                    .padding(.horizontal, teaserPadding)
                    .padding(.top, teaserPadding)
                }
                
                // Content overlay (bottom, overlays image with dark background, max 50% height)
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                        // Title (comes from bottom)
                        Text(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
                            .font(BorealisTypography.headingM())
                            .foregroundColor(.white)
                            .offset(y: isVisible ? 0 : 20)
                            .opacity(isVisible ? 1 : 0)
                            .animation(
                                .easeOut(duration: animationDuration)
                                .delay(animationDelay + 0.2),
                                value: isVisible
                            )
                        
                        // Description (comes from bottom)
                        let descriptionRaw = cardData.description.large.isEmpty 
                            ? cardData.description.small 
                            : cardData.description.large
                        let descriptionText = stripHTMLTags(from: descriptionRaw)
                        Text(descriptionText)
                            .font(BorealisTypography.body())
                            .foregroundColor(.white.opacity(0.9))
                            .lineLimit(3)
                            .offset(y: isVisible ? 0 : 20)
                            .opacity(isVisible ? 1 : 0)
                            .animation(
                                .easeOut(duration: animationDuration)
                                .delay(animationDelay + 0.3),
                                value: isVisible
                            )
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: cardHeight * 0.5)
                    .padding(BorealisSpacing.lg)
                    .background(
                        Group {
                            if isHovered {
                                overlayBackgroundColor.opacity(0.9)
                            } else {
                                overlayBackgroundColor.opacity(0.8)
                            }
                        }
                    )
                    .animation(.easeInOut(duration: 0.2), value: isHovered)
                }
            }
            .frame(height: cardHeight)
        }
        .buttonStyle(CardConciseButtonStyle())
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: BorealisRadius.lg))
        .overlay(
            RoundedRectangle(cornerRadius: BorealisRadius.lg)
                .stroke(
                    isHovered ? BorealisColors.primary : Color.clear,
                    lineWidth: 2
                )
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
        .onAppear {
            isVisible = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    isVisible = true
                }
            }
        }
        .onDisappear {
            isVisible = false
        }
        .id(animationTrigger)
        .accessibilityLabel(cardData.headline.large.isEmpty ? cardData.headline.small : cardData.headline.large)
        .accessibilityHint(cardData.action?.link.title ?? "Tap to open link")
    }
    
    // Public method to reset animation
    public func resetAnimation() {
        isVisible = false
        animationTrigger = UUID()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                isVisible = true
            }
        }
    }
    
    // Helper function to handle card tap
    private func handleCardTap(href: String) {
        #if canImport(UIKit)
        if let url = URL(string: href), href != "#" {
            UIApplication.shared.open(url)
        }
        #endif
    }
    
    // Helper function to strip HTML tags
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
            .replacingOccurrences(of: "<html>", with: "")
            .replacingOccurrences(of: "</html>", with: "")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<strong>", with: "")
            .replacingOccurrences(of: "</strong>", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return decoded ?? html
    }
}

/// Button style for Card Concise to remove default button styling
private struct CardConciseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    PreviewWrapper()
}

@available(iOS 15.0, *)
private struct PreviewWrapper: View {
    let sampleCardData = CardDataItem(
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
    )
    
    var body: some View {
        ScrollView {
            VStack(spacing: BorealisSpacing.lg) {
                BorealisCardConcise(cardData: sampleCardData)
                    .padding()
            }
        }
    }
}
