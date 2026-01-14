import SwiftUI
import BorealisKit

struct AccordionGroupPatternContent: View {
    let accordionItems: [AccordionItem]
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Single Expansion Mode
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Single Expansion Mode")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Only one section can be open at a time. Opening a new section automatically closes the previously open one.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordionGroup(
                    items: accordionItems,
                    expansionMode: .single,
                    variant: .defaultStyle,
                    size: .lg
                ) { item in
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        Text("Content for \(item.title)")
                            .font(BorealisTypography.body())
                            .foregroundColor(BorealisColors.textSecondary)
                        Text("Opening one closes others.")
                            .font(BorealisTypography.bodySmall())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
            }
            
            // Multiple Expansion Mode
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Multiple Expansion Mode")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Multiple sections can be open simultaneously. Users can expand or collapse each section independently.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordionGroup(
                    items: accordionItems,
                    expansionMode: .multiple,
                    variant: .bordered,
                    size: .lg
                ) { item in
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        Text("Content for \(item.title)")
                            .font(BorealisTypography.body())
                            .foregroundColor(BorealisColors.textSecondary)
                        Text("All can be open at once.")
                            .font(BorealisTypography.bodySmall())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
            }
            
            // Size Variants
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Size Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Accordion groups support different sizes.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordionGroup(
                    items: accordionItems,
                    expansionMode: .multiple,
                    variant: .defaultStyle,
                    size: .sm
                ) { item in
                    Text("Small size group - \(item.title)")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
            
            // Grouped vs Ungrouped
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Grouped vs Ungrouped")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Grouped accordions have spacing between items. Ungrouped accordions are tightly packed.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAccordionGroup(
                    items: accordionItems,
                    expansionMode: .multiple,
                    variant: .defaultStyle,
                    grouped: false
                ) { item in
                    Text("Ungrouped - \(item.title)")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Accordion Group Props")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • expansionMode: Single or multiple expansion
                    • variant: Style variant
                    • size: Size variant (sm, lg)
                    • chevron: Chevron position
                    • alignRight: Align titles to the right
                    • emphasis: Emphasize accordions
                    • grouped: Add spacing between items
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
