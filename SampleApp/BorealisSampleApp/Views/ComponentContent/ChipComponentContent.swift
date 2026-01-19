import SwiftUI
import BorealisKit

struct ChipComponentContent: View {
    @State private var selectedChips: Set<String> = ["Selected"]
    @State private var chips: [String] = ["Removable 1", "Removable 2", "Removable 3"]
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Chip Variants Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Chip Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chips support different visual states for user interaction.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: BorealisSpacing.sm) {
                    BorealisChip("Default")
                    BorealisChip("Selected", variant: .selected)
                    BorealisChip("Disabled", variant: .disabled)
                }
            }
            
            // Chip Sizes Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Chip Sizes")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chips are available in three sizes: small, medium (default), and large.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    HStack(spacing: BorealisSpacing.sm) {
                        BorealisChip("Small", size: .small)
                        BorealisChip("Medium", size: .medium)
                        BorealisChip("Large", size: .large)
                    }
                }
            }
            
            // Chips with Icons Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Chips with Icons")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chips can include leading or trailing icons for additional context.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    HStack(spacing: BorealisSpacing.sm) {
                        BorealisChip("Leading", leadingIcon: "star.fill")
                        BorealisChip("Trailing", trailingIcon: "chevron.right")
                        BorealisChip("Both", leadingIcon: "tag.fill", trailingIcon: "checkmark")
                    }
                    
                    HStack(spacing: BorealisSpacing.sm) {
                        BorealisChip("Favorite", variant: .selected, leadingIcon: "heart.fill")
                        BorealisChip("New", variant: .selected, leadingIcon: "sparkles")
                        BorealisChip("Hot", variant: .selected, leadingIcon: "flame.fill")
                    }
                }
            }
            
            // Removable Chips Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Removable Chips")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chips can include a remove button for dynamic tag management.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                FlowLayout(spacing: BorealisSpacing.sm) {
                    ForEach(chips, id: \.self) { chip in
                        BorealisChip(
                            chip,
                            showRemoveButton: true,
                            onRemove: {
                                chips.removeAll { $0 == chip }
                            }
                        )
                    }
                }
            }
            
            // Selectable Chips Section
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Selectable Chips")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chips can be made selectable for filtering or selection interfaces.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                FlowLayout(spacing: BorealisSpacing.sm) {
                    ForEach(["Option 1", "Option 2", "Option 3", "Selected", "Option 5"], id: \.self) { option in
                        BorealisChip(
                            option,
                            variant: selectedChips.contains(option) ? .selected : .defaultStyle,
                            onTap: {
                                if selectedChips.contains(option) {
                                    selectedChips.remove(option)
                                } else {
                                    selectedChips.insert(option)
                                }
                            }
                        )
                    }
                }
            }
            
            // Interactive Examples
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Interactive Examples")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Chips can handle tap events for custom interactions.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: BorealisSpacing.sm) {
                    BorealisChip("Tap Me", onTap: {
                        print("Chip tapped")
                    })
                    BorealisChip("With Icon", leadingIcon: "hand.tap", onTap: {
                        print("Chip with icon tapped")
                    })
                }
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Chip Component Props")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • title: Chip text label
                    • variant: Visual style (defaultStyle, selected, disabled)
                    • size: Chip size (small, medium, large)
                    • leadingIcon: Optional SF Symbol name for leading icon
                    • trailingIcon: Optional SF Symbol name for trailing icon
                    • showRemoveButton: Boolean to show remove button
                    • onTap: Optional closure executed when chip is tapped
                    • onRemove: Optional closure executed when remove button is tapped
                    
                    Variant Details:
                    - defaultStyle: Standard chip with border and background
                    - selected: Highlighted chip with primary color border and background
                    - disabled: Muted chip that doesn't respond to interactions
                    
                    Size Details:
                    - small: Compact chip with minimal padding (4pt vertical, 8pt horizontal)
                    - medium: Default size with standard padding (6pt vertical, 12pt horizontal)
                    - large: Larger chip with more padding (8pt vertical, 16pt horizontal)
                    
                    Icon Support:
                    - Leading icons appear before the text
                    - Trailing icons appear after the text
                    - Remove button replaces trailing icon when enabled
                    - Icons automatically scale with chip size
                    
                    Use Cases:
                    - Tags and labels
                    - Filter chips
                    - Selection interfaces
                    - Dynamic tag lists
                    - Status indicators
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}

// FlowLayout helper for wrapping chips
struct FlowLayout: Layout {
    var spacing: CGFloat
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.width ?? 0,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.frames[index].minX,
                                     y: bounds.minY + result.frames[index].minY),
                         proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            var maxWidthUsed: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                
                frames.append(CGRect(x: currentX, y: currentY, width: size.width, height: size.height))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
                maxWidthUsed = max(maxWidthUsed, currentX - spacing)
            }
            
            self.size = CGSize(width: maxWidthUsed, height: currentY + lineHeight)
        }
    }
}
