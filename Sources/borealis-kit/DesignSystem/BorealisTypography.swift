import SwiftUI

/// Borealis Design System Typography
public struct BorealisTypography {
    // Font Sizes
    public static let fontSizeXL: CGFloat = 32
    public static let fontSizeL: CGFloat = 24
    public static let fontSizeM: CGFloat = 18
    public static let fontSizeS: CGFloat = 16
    public static let fontSizeXS: CGFloat = 14
    public static let fontSizeXXS: CGFloat = 12
    
    // Font Weights
    public static let fontWeightBold = Font.Weight.bold
    public static let fontWeightSemibold = Font.Weight.semibold
    public static let fontWeightRegular = Font.Weight.regular
    public static let fontWeightLight = Font.Weight.light
    
    // Predefined Text Styles
    public static func headingXL() -> Font {
        .system(size: fontSizeXL, weight: fontWeightBold)
    }
    
    public static func headingL() -> Font {
        .system(size: fontSizeL, weight: fontWeightBold)
    }
    
    public static func headingM() -> Font {
        .system(size: fontSizeM, weight: fontWeightSemibold)
    }
    
    public static func body() -> Font {
        .system(size: fontSizeS, weight: fontWeightRegular)
    }
    
    public static func bodySmall() -> Font {
        .system(size: fontSizeXS, weight: fontWeightRegular)
    }
    
    public static func caption() -> Font {
        .system(size: fontSizeXXS, weight: fontWeightRegular)
    }
}
