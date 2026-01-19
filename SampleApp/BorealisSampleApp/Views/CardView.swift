import SwiftUI
import BorealisKit

struct CardView: View {
    @EnvironmentObject var themeManager: BorealisThemeManager
    @Environment(\.colorScheme) var systemColorScheme
    @State private var showThemePopover = false
    @State private var showColorSchemePopover = false
    @State private var showDarkModeAlert = false
    @State private var colorSchemeOverride: ColorScheme? = nil
    
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
            .id(themeManager.currentTheme) // Force view update on theme change
            .preferredColorScheme(.light) // Always keep in light mode until dark mode is ready
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showThemePopover = true
                    }) {
                        HStack(spacing: BorealisSpacing.xs) {
                            Image(systemName: "paintpalette.fill")
                            Text(themeManager.currentTheme.rawValue)
                                .font(BorealisTypography.body())
                        }
                        .foregroundColor(BorealisColors.primary)
                    }
                    .popover(isPresented: $showThemePopover, attachmentAnchor: .point(.top)) {
                        themePopoverContent
                            .presentationCompactAdaptation(.popover)
                    }
                }
            }
        }
    }
    
    // MARK: - Theme Popover
    
    private var themePopoverContent: some View {
        VStack(spacing: BorealisSpacing.sm) {
            ForEach(BorealisTheme.allCases, id: \.self) { theme in
                Button(action: {
                    themeManager.currentTheme = theme
                    showThemePopover = false
                }) {
                    HStack(spacing: BorealisSpacing.sm) {
                        // Color preview swatches
                        HStack(spacing: 2) {
                            Circle()
                                .fill(themeColor(for: theme, isPrimary: true))
                                .frame(width: 16, height: 16)
                            Circle()
                                .fill(themeColor(for: theme, isPrimary: false))
                                .frame(width: 16, height: 16)
                        }
                        
                        Text(theme.rawValue)
                            .font(BorealisTypography.bodySmall())
                            .fontWeight(themeManager.currentTheme == theme ? .semibold : .regular)
                            .foregroundColor(BorealisColors.textPrimary)
                        
                        Spacer()
                        
                        if themeManager.currentTheme == theme {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(BorealisColors.primary)
                        }
                    }
                    .padding(.horizontal, BorealisSpacing.sm)
                    .padding(.vertical, BorealisSpacing.sm)
                    .background(
                        themeManager.currentTheme == theme ?
                        BorealisColors.primary.opacity(0.08) :
                        Color.clear
                    )
                    .cornerRadius(BorealisRadius.md)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(BorealisSpacing.sm)
        .background(BorealisColors.surface)
        .cornerRadius(BorealisRadius.lg)
        .shadow(
            color: BorealisShadow.sm.color,
            radius: BorealisShadow.sm.radius,
            x: 0,
            y: BorealisShadow.sm.y
        )
    }
    
    private func themeColor(for theme: BorealisTheme, isPrimary: Bool) -> Color {
        switch theme {
        case .alaska:
            return isPrimary ? Color("003A8F") : Color("00A6A6")
        case .hawaii:
            return isPrimary ? Color("4B1E6D") : Color("C81E78")
        }
    }
    
    // MARK: - Color Scheme
    
    private var colorSchemeIcon: String {
        let currentScheme = colorSchemeOverride ?? systemColorScheme
        return currentScheme == .dark ? "moon.fill" : "sun.max.fill"
    }
    
    private var colorSchemePopoverContent: some View {
        VStack(spacing: BorealisSpacing.sm) {
            ForEach([ColorScheme.light, ColorScheme.dark], id: \.self) { scheme in
                Button(action: {
                    let currentScheme = colorSchemeOverride ?? systemColorScheme
                    showColorSchemePopover = false
                    
                    if scheme != currentScheme {
                        colorSchemeOverride = scheme
                        // Show alert when dark mode is selected
                        if scheme == .dark {
                            // Delay alert to allow popover to dismiss first
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                showDarkModeAlert = true
                            }
                        }
                    }
                }) {
                    HStack(spacing: BorealisSpacing.sm) {
                        Image(systemName: scheme == .dark ? "moon.fill" : "sun.max.fill")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(BorealisColors.textPrimary)
                            .frame(width: 20)
                        
                        Text(scheme == .dark ? "Dark" : "Light")
                            .font(BorealisTypography.bodySmall())
                            .fontWeight(currentColorScheme == scheme ? .semibold : .regular)
                            .foregroundColor(BorealisColors.textPrimary)
                        
                        Spacer()
                        
                        if currentColorScheme == scheme {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(BorealisColors.primary)
                        }
                    }
                    .padding(.horizontal, BorealisSpacing.sm)
                    .padding(.vertical, BorealisSpacing.sm)
                    .background(
                        currentColorScheme == scheme ?
                        BorealisColors.primary.opacity(0.08) :
                        Color.clear
                    )
                    .cornerRadius(BorealisRadius.md)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(BorealisSpacing.sm)
        .background(BorealisColors.surface)
        .cornerRadius(BorealisRadius.lg)
        .shadow(
            color: BorealisShadow.sm.color,
            radius: BorealisShadow.sm.radius,
            x: 0,
            y: BorealisShadow.sm.y
        )
    }
    
    private var currentColorScheme: ColorScheme {
        colorSchemeOverride ?? systemColorScheme
    }
}
