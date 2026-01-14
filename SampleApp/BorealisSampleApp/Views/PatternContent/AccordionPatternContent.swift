import SwiftUI
import BorealisKit

struct AccordionPatternContent: View {
    @Binding var accordionExpanded1: Bool
    @Binding var accordionExpanded2: Bool
    @Binding var accordionExpanded3: Bool
    @Binding var accordionExpanded4: Bool
    @Binding var accordionExpanded5: Bool
    @Binding var accordionExpanded6: Bool
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Size Variants
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Size Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Accordions support different sizes: small (sm) for compact spacing and large (lg) for more padding.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordion(
                    title: "Small Size (sm)",
                    isExpanded: $accordionExpanded1,
                    variant: .defaultStyle,
                    size: .sm
                ) {
                    Text("Small size accordion with compact spacing.")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "Large Size (lg)",
                    isExpanded: $accordionExpanded2,
                    variant: .defaultStyle,
                    size: .lg
                ) {
                    Text("Large size accordion with more padding.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
            
            // Chevron Options
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Chevron Options")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chevron icon can be positioned on the left, right, or hidden completely.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordion(
                    title: "Chevron Left",
                    isExpanded: $accordionExpanded3,
                    variant: .defaultStyle,
                    chevron: .left
                ) {
                    Text("Chevron icon on the left side.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "Chevron Right",
                    isExpanded: $accordionExpanded4,
                    variant: .defaultStyle,
                    chevron: .right
                ) {
                    Text("Chevron icon on the right side (default).")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "No Chevron",
                    isExpanded: $accordionExpanded5,
                    variant: .defaultStyle,
                    chevron: .some(.none)
                ) {
                    Text("No chevron icon displayed.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
            
            // Alignment and Emphasis
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Alignment & Emphasis")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Accordion titles can be right-aligned, and emphasis styling can be applied for bolder text.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordion(
                    title: "Right Aligned",
                    isExpanded: $accordionExpanded6,
                    variant: .defaultStyle,
                    alignRight: true
                ) {
                    Text("Title text is aligned to the right.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "Emphasized Accordion",
                    isExpanded: .constant(false),
                    variant: .defaultStyle,
                    emphasis: true
                ) {
                    Text("This accordion has emphasis styling with bolder text.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
            
            // Style Variants
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Style Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Different visual styles are available: default, bordered, filled, and minimal.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordion(
                    title: "Default Style",
                    isExpanded: .constant(false),
                    variant: .defaultStyle
                ) {
                    Text("Default style with subtle shadow.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "Bordered Style",
                    isExpanded: .constant(false),
                    variant: .bordered
                ) {
                    Text("Bordered style with visible border.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "Filled Style",
                    isExpanded: .constant(false),
                    variant: .filled
                ) {
                    Text("Filled style with background color.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                
                BorealisAccordion(
                    title: "Minimal Style",
                    isExpanded: .constant(false),
                    variant: .minimal
                ) {
                    Text("Minimal style with no borders or shadows.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Accordion Props")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • variant: Style variant (defaultStyle, bordered, filled, minimal)
                    • size: Size variant (sm, lg)
                    • chevron: Chevron position (left, right, none)
                    • alignRight: Align title text to the right
                    • emphasis: Emphasize the accordion with bolder styling
                    • expanded: Initial expanded state
                    • showDivider: Show divider between header and content
                    • spacing: Custom spacing between elements
                    • animationDuration: Animation duration for expand/collapse
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
