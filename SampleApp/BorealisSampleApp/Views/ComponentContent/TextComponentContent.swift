import SwiftUI
import BorealisKit

struct TextComponentContent: View {
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Text Variants Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Text Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Different typography styles for headings and body text.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    BorealisText("Heading XL", variant: .headingXL)
                    BorealisText("Heading L", variant: .headingL)
                    BorealisText("Heading M", variant: .headingM)
                    BorealisText("Body text example", variant: .body)
                    BorealisText("Body Small text", variant: .bodySmall)
                    BorealisText("Caption text", variant: .caption)
                }
            }
            
            // Color Variants Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Color Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Text can use different color variants for semantic meaning.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    BorealisText("Primary text", color: .primary)
                    BorealisText("Secondary text", color: .secondary)
                    BorealisText("Muted text", color: .muted)
                    BorealisText("Success message", color: .success)
                    BorealisText("Warning message", color: .warning)
                    BorealisText("Error message", color: .error)
                    BorealisText("Info message", color: .info)
                }
            }
            
            // Font Weights Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Font Weights")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Text supports different font weights for emphasis.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    BorealisText("Regular weight text", weight: .regular)
                    BorealisText("Semibold weight text", weight: .semibold)
                    BorealisText("Bold weight text", weight: .bold)
                }
            }
            
            // Text Alignment Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Text Alignment")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Text can be aligned left, center, or right.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.sm) {
                    BorealisText("Left aligned text", alignment: .leading)
                    BorealisText("Center aligned text", alignment: .center)
                    BorealisText("Right aligned text", alignment: .trailing)
                }
            }
            
            // Line Limit Example
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Line Limit")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Text can be limited to a specific number of lines.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisText(
                    "This is a very long text that will be truncated after two lines to demonstrate the line limit functionality of the BorealisText component.",
                    lineLimit: 2
                )
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Text Component Props")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • variant: Text style (headingXL, headingL, headingM, body, bodySmall, caption)
                    • color: Color variant (primary, secondary, muted, inverse, success, warning, error, info, custom)
                    • weight: Font weight (regular, semibold, bold)
                    • alignment: Text alignment (leading, center, trailing)
                    • lineLimit: Optional maximum number of lines
                    • multilineTextAlignment: Alignment for multiline text
                    
                    Variant Details:
                    - headingXL: Largest heading (32pt, bold)
                    - headingL: Large heading (24pt, bold)
                    - headingM: Medium heading (18pt, semibold)
                    - body: Standard body text (16pt, regular)
                    - bodySmall: Small body text (14pt, regular)
                    - caption: Caption text (12pt, regular)
                    
                    Color Variants:
                    - primary: Primary text color
                    - secondary: Secondary text color
                    - muted: Muted text color (70% opacity)
                    - inverse: White text for dark backgrounds
                    - success/warning/error/info: Semantic colors
                    - custom: Custom color
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
