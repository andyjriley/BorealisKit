import SwiftUI

/// Borealis Design System Colors
public struct BorealisColors {
    // Shared theme manager instance
    private static var sharedThemeManager: BorealisThemeManager?
    
    /// Set the shared theme manager (should be called at app startup)
    public static func setThemeManager(_ manager: BorealisThemeManager) {
        sharedThemeManager = manager
    }
    
    // Primary Colors
    public static var primary: Color {
        sharedThemeManager?.currentTheme.primary ?? Color(red: 0.2, green: 0.4, blue: 0.8)
    }
    
    public static var primaryDark: Color {
        sharedThemeManager?.currentTheme.primaryDark ?? Color(red: 0.15, green: 0.3, blue: 0.7)
    }
    
    public static var primaryLight: Color {
        sharedThemeManager?.currentTheme.primaryLight ?? Color(red: 0.3, green: 0.5, blue: 0.9)
    }
    
    public static var primaryText: Color {
        sharedThemeManager?.currentTheme.primaryText ?? Color(red: 0.0, green: 0.2, blue: 0.5)
    }
    
    // Secondary Colors
    public static var secondary: Color {
        sharedThemeManager?.currentTheme.secondary ?? Color(red: 0.6, green: 0.6, blue: 0.6)
    }
    
    public static var secondaryDark: Color {
        sharedThemeManager?.currentTheme.secondaryDark ?? Color(red: 0.4, green: 0.4, blue: 0.4)
    }
    
    public static var secondaryLight: Color {
        sharedThemeManager?.currentTheme.secondaryLight ?? Color(red: 0.8, green: 0.8, blue: 0.8)
    }
    
    // Semantic Colors (theme-independent)
    public static let success = Color(red: 0.2, green: 0.7, blue: 0.3)
    public static let warning = Color(red: 1.0, green: 0.7, blue: 0.0)
    public static let error = Color(red: 0.9, green: 0.2, blue: 0.2)
    public static let info = Color(red: 0.2, green: 0.6, blue: 0.9)
    
    // Neutral Colors
    public static var background: Color {
        sharedThemeManager?.currentTheme.background ?? Color(red: 0.98, green: 0.98, blue: 0.98)
    }
    
    public static let surface = Color.white
    
    public static var textPrimary: Color {
        sharedThemeManager?.currentTheme.textPrimary ?? Color(red: 0.1, green: 0.1, blue: 0.1)
    }
    
    public static var textSecondary: Color {
        sharedThemeManager?.currentTheme.textSecondary ?? Color(red: 0.5, green: 0.5, blue: 0.5)
    }
    
    public static var border: Color {
        sharedThemeManager?.currentTheme.border ?? Color(red: 0.9, green: 0.9, blue: 0.9)
    }
    
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
