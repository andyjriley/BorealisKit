import SwiftUI

/// Borealis Design System Colors
public struct BorealisColors {
    // Primary Colors
    public static let primary = Color(red: 0.2, green: 0.4, blue: 0.8)
    public static let primaryDark = Color(red: 0.15, green: 0.3, blue: 0.7)
    public static let primaryLight = Color(red: 0.3, green: 0.5, blue: 0.9)
    public static let primaryText = Color(red: 0.0, green: 0.2, blue: 0.5) // Dark blue for secondary buttons
    
    // Secondary Colors
    public static let secondary = Color(red: 0.6, green: 0.6, blue: 0.6)
    public static let secondaryDark = Color(red: 0.4, green: 0.4, blue: 0.4)
    public static let secondaryLight = Color(red: 0.8, green: 0.8, blue: 0.8)
    
    // Semantic Colors
    public static let success = Color(red: 0.2, green: 0.7, blue: 0.3)
    public static let warning = Color(red: 1.0, green: 0.7, blue: 0.0)
    public static let error = Color(red: 0.9, green: 0.2, blue: 0.2)
    public static let info = Color(red: 0.2, green: 0.6, blue: 0.9)
    
    // Neutral Colors
    public static let background = Color(red: 0.98, green: 0.98, blue: 0.98)
    public static let surface = Color.white
    public static let textPrimary = Color(red: 0.1, green: 0.1, blue: 0.1)
    public static let textSecondary = Color(red: 0.5, green: 0.5, blue: 0.5)
    public static let border = Color(red: 0.9, green: 0.9, blue: 0.9)
    
    // Dark Mode Support
    public static func background(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color(red: 0.1, green: 0.1, blue: 0.1) : background
    }
    
    public static func surface(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color(red: 0.15, green: 0.15, blue: 0.15) : surface
    }
    
    public static func textPrimary(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color.white : textPrimary
    }
}
