import SwiftUI
import BorealisKit


struct StylesView: View {
    // Typography Controls
    @State private var selectedFontSize: CGFloat = BorealisTypography.fontSizeS
    @State private var selectedFontWeight: Font.Weight = .regular
    @State private var sampleText = "The quick brown fox jumps over the lazy dog"
    
    // Spacing Controls
    @State private var selectedSpacing: CGFloat = BorealisSpacing.md
    
    // Radius Controls
    @State private var selectedRadius: CGFloat = BorealisRadius.md
    
    // Shadow Controls
    @State private var selectedShadow: ShadowType = .sm
    @State private var shadowOpacity: Double = 0.1
    @State private var shadowRadius: CGFloat = 2
    @State private var shadowY: CGFloat = 1
    
    enum ShadowType: String, CaseIterable {
        case sm = "Small"
        case md = "Medium"
        case lg = "Large"
        case custom = "Custom"
        
        var shadow: BorealisShadow.Shadow {
            switch self {
            case .sm:
                return BorealisShadow.sm
            case .md:
                return BorealisShadow.md
            case .lg:
                return BorealisShadow.lg
            case .custom:
                return BorealisShadow.Shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: BorealisSpacing.xl) {
                    // Colors Section
                    colorsSection
                    
                    // Typography Section
                    typographySection
                    
                    // Spacing Section
                    spacingSection
                    
                    // Radius Section
                    radiusSection
                    
                    // Shadows Section
                    shadowsSection
                }
                .padding(BorealisSpacing.lg)
            }
            .navigationTitle("Styles")
            .background(BorealisColors.background)
        }
    }
    
    // MARK: - Colors Section
    
    private var colorsSection: some View {
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
                Text("Colors")
                    .font(BorealisTypography.headingM())
                
                // Primary Colors
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Primary Colors")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: BorealisSpacing.md) {
                            colorSwatch("Primary", color: BorealisColors.primary)
                            colorSwatch("Primary Dark", color: BorealisColors.primaryDark)
                            colorSwatch("Primary Light", color: BorealisColors.primaryLight)
                            colorSwatch("Primary Text", color: BorealisColors.primaryText)
                        }
                        .padding(.horizontal, BorealisSpacing.xs)
                    }
                }
                
                // Secondary Colors
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Secondary Colors")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: BorealisSpacing.md) {
                            colorSwatch("Secondary", color: BorealisColors.secondary)
                            colorSwatch("Secondary Dark", color: BorealisColors.secondaryDark)
                            colorSwatch("Secondary Light", color: BorealisColors.secondaryLight)
                        }
                        .padding(.horizontal, BorealisSpacing.xs)
                    }
                }
                
                // Semantic Colors
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Semantic Colors")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: BorealisSpacing.md) {
                            colorSwatch("Success", color: BorealisColors.success)
                            colorSwatch("Warning", color: BorealisColors.warning)
                            colorSwatch("Error", color: BorealisColors.error)
                            colorSwatch("Info", color: BorealisColors.info)
                        }
                        .padding(.horizontal, BorealisSpacing.xs)
                    }
                }
                
                // Neutral Colors
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Neutral Colors")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: BorealisSpacing.md) {
                            colorSwatch("Background", color: BorealisColors.background)
                            colorSwatch("Surface", color: BorealisColors.surface)
                            colorSwatch("Text Primary", color: BorealisColors.textPrimary)
                            colorSwatch("Text Secondary", color: BorealisColors.textSecondary)
                            colorSwatch("Border", color: BorealisColors.border)
                        }
                        .padding(.horizontal, BorealisSpacing.xs)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func colorSwatch(_ name: String, color: Color) -> some View {
        VStack(spacing: BorealisSpacing.xs) {
            RoundedRectangle(cornerRadius: BorealisRadius.md)
                .fill(color)
                .frame(width: 60, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: BorealisRadius.md)
                        .stroke(BorealisColors.border, lineWidth: 1)
                )
            
            VStack(spacing: 2) {
                Text(name)
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minHeight: 14)
                
                Text(hexString(for: color))
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(height: 14)
            }
            .frame(height: 32, alignment: .top)
        }
        .frame(width: 80)
    }
    
    private func hexString(for color: Color) -> String {
        #if canImport(UIKit)
        let uiColor = UIColor(color)
        
        // Get RGB components
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        // Try to get RGB components directly
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let r = Int(round(red * 255))
            let g = Int(round(green * 255))
            let b = Int(round(blue * 255))
            return String(format: "#%02X%02X%02X", r, g, b)
        }
        
        // Fallback: convert to RGB color space
        guard let rgbColorSpace = CGColorSpace(name: CGColorSpace.sRGB),
              let cgColor = uiColor.cgColor.converted(to: rgbColorSpace, intent: .defaultIntent, options: nil),
              cgColor.numberOfComponents >= 3 else {
            return "#000000"
        }
        
        let components = cgColor.components ?? []
        if components.count >= 3 {
            let r = Int(round(components[0] * 255))
            let g = Int(round(components[1] * 255))
            let b = Int(round(components[2] * 255))
            return String(format: "#%02X%02X%02X", r, g, b)
        }
        
        return "#000000"
        #else
        return "#000000"
        #endif
    }
    
    // MARK: - Typography Section
    
    private var typographySection: some View {
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
                Text("Typography")
                    .font(BorealisTypography.headingM())
                
                // Font Size Control
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Font Size: \(Int(selectedFontSize))pt")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    Slider(value: $selectedFontSize, in: 12...40, step: 1)
                    
                    HStack {
                        Text("12pt")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                        Spacer()
                        Text("40pt")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
                
                // Font Weight Control
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Font Weight")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    Picker("Font Weight", selection: $selectedFontWeight) {
                        Text("Light").tag(Font.Weight.light)
                        Text("Regular").tag(Font.Weight.regular)
                        Text("Semibold").tag(Font.Weight.semibold)
                        Text("Bold").tag(Font.Weight.bold)
                    }
                    .pickerStyle(.segmented)
                }
                
                Divider()
                
                // Predefined Styles
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Predefined Styles")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                        Text("Heading XL")
                            .font(BorealisTypography.headingXL())
                        
                        Text("Heading L")
                            .font(BorealisTypography.headingL())
                        
                        Text("Heading M")
                            .font(BorealisTypography.headingM())
                        
                        Text("Body")
                            .font(BorealisTypography.body())
                        
                        Text("Body Small")
                            .font(BorealisTypography.bodySmall())
                        
                        Text("Caption")
                            .font(BorealisTypography.caption())
                    }
                }
                
                Divider()
                
                // Custom Preview
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Custom Preview")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    TextField("Sample text", text: $sampleText)
                        .textFieldStyle(.roundedBorder)
                    
                    Text(sampleText)
                        .font(.system(size: selectedFontSize, weight: selectedFontWeight))
                        .foregroundColor(BorealisColors.textPrimary)
                        .padding(BorealisSpacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(BorealisColors.surface)
                        .cornerRadius(BorealisRadius.md)
                }
            }
        }
    }
    
    // MARK: - Spacing Section
    
    private var spacingSection: some View {
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
                Text("Spacing")
                    .font(BorealisTypography.headingM())
                
                // Spacing Values
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Spacing Values")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        spacingRow("XS", value: BorealisSpacing.xs)
                        spacingRow("SM", value: BorealisSpacing.sm)
                        spacingRow("MD", value: BorealisSpacing.md)
                        spacingRow("LG", value: BorealisSpacing.lg)
                        spacingRow("XL", value: BorealisSpacing.xl)
                        spacingRow("XXL", value: BorealisSpacing.xxl)
                    }
                }
                
                Divider()
                
                // Interactive Spacing Preview
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Interactive Preview")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    Text("Spacing: \(Int(selectedSpacing))pt")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    Slider(value: $selectedSpacing, in: 4...48, step: 4)
                    
                    HStack(spacing: selectedSpacing) {
                        RoundedRectangle(cornerRadius: BorealisRadius.sm)
                            .fill(BorealisColors.primary)
                            .frame(width: 40, height: 40)
                        
                        RoundedRectangle(cornerRadius: BorealisRadius.sm)
                            .fill(BorealisColors.secondary)
                            .frame(width: 40, height: 40)
                        
                        RoundedRectangle(cornerRadius: BorealisRadius.sm)
                            .fill(BorealisColors.success)
                            .frame(width: 40, height: 40)
                    }
                    .padding(BorealisSpacing.md)
                    .background(BorealisColors.background)
                    .cornerRadius(BorealisRadius.md)
                }
            }
        }
    }
    
    private func spacingRow(_ name: String, value: CGFloat) -> some View {
        HStack {
            Text(name)
                .font(BorealisTypography.bodySmall())
                .frame(width: 40, alignment: .leading)
            
            Text("\(Int(value))pt")
                .font(BorealisTypography.bodySmall())
                .foregroundColor(BorealisColors.textSecondary)
                .frame(width: 50, alignment: .leading)
            
            Rectangle()
                .fill(BorealisColors.primary.opacity(0.3))
                .frame(width: value, height: 8)
                .cornerRadius(4)
        }
    }
    
    // MARK: - Radius Section
    
    private var radiusSection: some View {
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
                Text("Corner Radius")
                    .font(BorealisTypography.headingM())
                
                // Radius Values
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Radius Values")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                        radiusRow("None", value: BorealisRadius.none)
                        radiusRow("SM", value: BorealisRadius.sm)
                        radiusRow("MD", value: BorealisRadius.md)
                        radiusRow("LG", value: BorealisRadius.lg)
                        radiusRow("XL", value: BorealisRadius.xl)
                        radiusRow("Full", value: BorealisRadius.full)
                    }
                }
                
                Divider()
                
                // Interactive Radius Preview
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Interactive Preview")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    Text("Radius: \(Int(selectedRadius))pt")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    Slider(value: $selectedRadius, in: 0...32, step: 1)
                    
                    RoundedRectangle(cornerRadius: selectedRadius)
                        .fill(BorealisColors.primary)
                        .frame(height: 100)
                        .overlay(
                            Text("Preview")
                                .font(BorealisTypography.headingM())
                                .foregroundColor(.white)
                        )
                }
            }
        }
    }
    
    private func radiusRow(_ name: String, value: CGFloat) -> some View {
        HStack(spacing: BorealisSpacing.md) {
            Text(name)
                .font(BorealisTypography.bodySmall())
                .frame(width: 50, alignment: .leading)
            
            Text(value == BorealisRadius.full ? "Full" : "\(Int(value))pt")
                .font(BorealisTypography.bodySmall())
                .foregroundColor(BorealisColors.textSecondary)
                .frame(width: 50, alignment: .leading)
            
            RoundedRectangle(cornerRadius: value)
                .fill(BorealisColors.primary.opacity(0.3))
                .frame(width: 80, height: 40)
        }
    }
    
    // MARK: - Shadows Section
    
    private var shadowsSection: some View {
        BorealisCard {
            VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
                Text("Shadows")
                    .font(BorealisTypography.headingM())
                
                // Shadow Types
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Shadow Types")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    Picker("Shadow Type", selection: $selectedShadow) {
                        ForEach(ShadowType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    let shadow = selectedShadow == .custom ? 
                        BorealisShadow.Shadow(
                            color: .black.opacity(shadowOpacity),
                            radius: shadowRadius,
                            x: 0,
                            y: shadowY
                        ) :
                        selectedShadow.shadow
                    
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        Text("Color Opacity: \(String(format: "%.2f", shadowOpacity))")
                        Text("Radius: \(Int(shadow.radius))pt")
                        Text("Y Offset: \(Int(shadow.y))pt")
                    }
                    .font(BorealisTypography.bodySmall())
                    .foregroundColor(BorealisColors.textSecondary)
                }
                
                // Custom Shadow Controls
                if selectedShadow == .custom {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                        Text("Custom Shadow Controls")
                            .font(BorealisTypography.body())
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                            Text("Opacity: \(String(format: "%.2f", shadowOpacity))")
                            Slider(value: $shadowOpacity, in: 0...1, step: 0.01)
                        }
                        
                        VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                            Text("Radius: \(Int(shadowRadius))pt")
                            Slider(value: $shadowRadius, in: 0...20, step: 1)
                        }
                        
                        VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                            Text("Y Offset: \(Int(shadowY))pt")
                            Slider(value: $shadowY, in: 0...10, step: 1)
                        }
                    }
                }
                
                Divider()
                
                // Shadow Preview
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text("Shadow Preview")
                        .font(BorealisTypography.body())
                        .fontWeight(.semibold)
                    
                    let previewShadow = selectedShadow == .custom ?
                        BorealisShadow.Shadow(
                            color: .black.opacity(shadowOpacity),
                            radius: shadowRadius,
                            x: 0,
                            y: shadowY
                        ) :
                        selectedShadow.shadow
                    
                    RoundedRectangle(cornerRadius: BorealisRadius.md)
                        .fill(BorealisColors.surface)
                        .frame(height: 100)
                        .shadow(
                            color: previewShadow.color,
                            radius: previewShadow.radius,
                            x: previewShadow.x,
                            y: previewShadow.y
                        )
                        .overlay(
                            Text("Shadow Preview")
                                .font(BorealisTypography.headingM())
                                .foregroundColor(BorealisColors.textPrimary)
                        )
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

#Preview {
    StylesView()
}
