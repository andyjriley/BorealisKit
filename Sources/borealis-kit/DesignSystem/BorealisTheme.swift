import SwiftUI

/// Theme options for the Borealis Design System.
///
/// Themes control the color palette used throughout the application.
/// Each theme provides a distinct set of primary, secondary, and accent colors.
///
/// ## Available Themes
///
/// - ``alaska``: Alaska theme with navy blue and teal colors
/// - ``hawaii``: Hawaii theme with purple and magenta colors
///
/// ## Examples
///
/// ```swift
/// let themeManager = BorealisThemeManager(theme: .alaska)
/// themeManager.currentTheme = .hawaii
/// ```
public enum BorealisTheme: String, CaseIterable {
    /// Alaska theme with navy blue (#003A8F) and teal (#00A6A6) colors.
    case alaska = "Alaska"
    /// Hawaii theme with purple (#4B1E6D) and magenta (#C81E78) colors.
    case hawaii = "Hawaii"
    
    // MARK: - Alaska Colors
    var alaskaNavy: Color {
        Color(hex: "#003A8F")
    }
    
    var alaskaTeal: Color {
        Color(hex: "#00A6A6")
    }
    
    var skyBlue: Color {
        Color(hex: "#6EC1E4")
    }
    
    var evergreen: Color {
        Color(hex: "#2F6F62")
    }
    
    var charcoal: Color {
        Color(hex: "#2B2B2B")
    }
    
    var lightGray: Color {
        Color(hex: "#F2F4F6")
    }
    
    // MARK: - Hawaii Colors
    var hawaiianPurple: Color {
        Color(hex: "#4B1E6D")
    }
    
    var hawaiianMagenta: Color {
        Color(hex: "#C81E78")
    }
    
    var oceanBlue: Color {
        Color(hex: "#0079C1")
    }
    
    var sunsetOrange: Color {
        Color(hex: "#F26A2E")
    }
    
    var palmGreen: Color {
        Color(hex: "#3A7D44")
    }
    
    var warmSand: Color {
        Color(hex: "#EFE6D8")
    }
    
    // MARK: - Theme-based Color Mapping
    var primary: Color {
        switch self {
        case .alaska:
            return alaskaNavy
        case .hawaii:
            return hawaiianPurple
        }
    }
    
    var primaryDark: Color {
        switch self {
        case .alaska:
            return Color(hex: "#002A6F") // Darker navy
        case .hawaii:
            return Color(hex: "#3A1555") // Darker purple
        }
    }
    
    var primaryLight: Color {
        switch self {
        case .alaska:
            return Color(hex: "#004AB3") // Lighter navy
        case .hawaii:
            return Color(hex: "#5C2A85") // Lighter purple
        }
    }
    
    var primaryText: Color {
        switch self {
        case .alaska:
            return alaskaNavy
        case .hawaii:
            return hawaiianPurple
        }
    }
    
    var secondary: Color {
        switch self {
        case .alaska:
            return alaskaTeal
        case .hawaii:
            return hawaiianMagenta
        }
    }
    
    var secondaryDark: Color {
        switch self {
        case .alaska:
            return evergreen
        case .hawaii:
            return Color(hex: "#A0185F") // Darker magenta
        }
    }
    
    var secondaryLight: Color {
        switch self {
        case .alaska:
            return skyBlue
        case .hawaii:
            return oceanBlue
        }
    }
    
    var background: Color {
        switch self {
        case .alaska:
            return lightGray
        case .hawaii:
            return warmSand
        }
    }
    
    var surface: Color {
        return .white
    }
    
    var textPrimary: Color {
        switch self {
        case .alaska:
            return charcoal
        case .hawaii:
            return Color(hex: "#2B2B2B") // Similar dark for readability
        }
    }
    
    var textSecondary: Color {
        switch self {
        case .alaska:
            return Color(hex: "#666666")
        case .hawaii:
            return Color(hex: "#666666")
        }
    }
    
    var border: Color {
        switch self {
        case .alaska:
            return Color(hex: "#E0E0E0")
        case .hawaii:
            return Color(hex: "#D4C4B0") // Warmer border
        }
    }
}

/// Theme Manager - ObservableObject to manage current theme
/// Manages the current theme for the Borealis Design System.
///
/// Use `BorealisThemeManager` to control which theme is active in your application.
/// The theme manager is an `ObservableObject`, so views automatically update when the theme changes.
///
/// ## Examples
///
/// ```swift
/// @StateObject private var themeManager = BorealisThemeManager(theme: .alaska)
///
/// // Change theme
/// themeManager.currentTheme = .hawaii
/// ```
public class BorealisThemeManager: ObservableObject {
    /// The currently active theme.
    ///
    /// When this value changes, all theme-aware components automatically update their colors.
    @Published public var currentTheme: BorealisTheme = .alaska
    
    /// Creates a new theme manager with the specified initial theme.
    ///
    /// - Parameter theme: The initial theme to use. Defaults to `.alaska`.
    public init(theme: BorealisTheme = .alaska) {
        self.currentTheme = theme
    }
}

// MARK: - Color Extension for Hex Support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
