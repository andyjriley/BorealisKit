import SwiftUI
import BorealisKit

struct ButtonComponentContent: View {
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Button Variants Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Button Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Different button styles for various use cases.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.md) {
                    BorealisButton("Primary Button", variant: .primary) {}
                    BorealisButton("Secondary Button", variant: .secondary) {}
                    BorealisButton("Outline Button", variant: .outline) {}
                    BorealisButton("Text Button", variant: .text) {}
                }
            }
            
            // Button Sizes Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Button Sizes")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Buttons are available in three sizes: small, medium (default), and large.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.md) {
                    BorealisButton("Small Button", variant: .primary, size: .small) {}
                    BorealisButton("Medium Button", variant: .primary, size: .medium) {}
                    BorealisButton("Large Button", variant: .primary, size: .large) {}
                }
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Button Props")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • variant: Button style (primary, secondary, outline, text)
                    • size: Button size (small, medium, large)
                    • title: Button text label
                    • action: Closure executed when button is tapped
                    
                    Variant Details:
                    - Primary: Filled button with primary color background
                    - Secondary: White background with primary text color border and text
                    - Outline: Transparent background with primary color border and text
                    - Text: Transparent background with primary color text, no border
                    
                    Size Details:
                    - Small: Compact padding and smaller font
                    - Medium: Default size with standard padding
                    - Large: Larger padding and bigger font
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
