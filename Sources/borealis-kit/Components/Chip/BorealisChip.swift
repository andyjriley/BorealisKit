import SwiftUI

/// Borealis Chip Component - Interactive tag/badge component
public struct BorealisChip: View {
    public enum Variant {
        case defaultStyle
        case selected
        case disabled
        
        var backgroundColor: Color {
            switch self {
            case .defaultStyle:
                return BorealisColors.background
            case .selected:
                return BorealisColors.primary.opacity(0.1)
            case .disabled:
                return BorealisColors.background.opacity(0.5)
            }
        }
        
        var textColor: Color {
            switch self {
            case .defaultStyle:
                return BorealisColors.textPrimary
            case .selected:
                return BorealisColors.primary
            case .disabled:
                return BorealisColors.textSecondary.opacity(0.5)
            }
        }
        
        var borderColor: Color {
            switch self {
            case .defaultStyle:
                return BorealisColors.border
            case .selected:
                return BorealisColors.primary
            case .disabled:
                return BorealisColors.border.opacity(0.5)
            }
        }
    }
    
    public enum Size {
        case small
        case medium
        case large
        
        var padding: EdgeInsets {
            switch self {
            case .small:
                return EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8)
            case .medium:
                return EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            case .large:
                return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small:
                return BorealisTypography.fontSizeXXS
            case .medium:
                return BorealisTypography.fontSizeXS
            case .large:
                return BorealisTypography.fontSizeS
            }
        }
        
        var iconSize: CGFloat {
            switch self {
            case .small:
                return 12
            case .medium:
                return 14
            case .large:
                return 16
            }
        }
    }
    
    let title: String
    let variant: Variant
    let size: Size
    let leadingIcon: String?
    let trailingIcon: String?
    let showRemoveButton: Bool
    let onTap: (() -> Void)?
    let onRemove: (() -> Void)?
    
    public init(
        _ title: String,
        variant: Variant = .defaultStyle,
        size: Size = .medium,
        leadingIcon: String? = nil,
        trailingIcon: String? = nil,
        showRemoveButton: Bool = false,
        onTap: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil
    ) {
        self.title = title
        self.variant = variant
        self.size = size
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.showRemoveButton = showRemoveButton
        self.onTap = onTap
        self.onRemove = onRemove
    }
    
    public var body: some View {
        HStack(spacing: size == .small ? BorealisSpacing.xs : BorealisSpacing.sm) {
            // Leading Icon
            if let leadingIcon = leadingIcon {
                Image(systemName: leadingIcon)
                    .font(.system(size: size.iconSize, weight: .medium))
                    .foregroundColor(variant.textColor)
            }
            
            // Title
            Text(title)
                .font(.system(size: size.fontSize, weight: .medium))
                .foregroundColor(variant.textColor)
            
            // Trailing Icon or Remove Button
            if showRemoveButton {
                Button(action: {
                    onRemove?()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: size.iconSize, weight: .medium))
                        .foregroundColor(variant == .disabled ? variant.textColor : BorealisColors.textSecondary)
                }
                .disabled(variant == .disabled)
            } else if let trailingIcon = trailingIcon {
                Image(systemName: trailingIcon)
                    .font(.system(size: size.iconSize, weight: .medium))
                    .foregroundColor(variant.textColor)
            }
        }
        .padding(size.padding)
        .background(variant.backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: BorealisRadius.full)
                .stroke(variant.borderColor, lineWidth: variant == .selected ? 2 : 1)
        )
        .cornerRadius(BorealisRadius.full)
        .opacity(variant == .disabled ? 0.6 : 1.0)
        .onTapGesture {
            if variant != .disabled {
                onTap?()
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
        // Variants
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Chip Variants")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.sm) {
                BorealisChip("Default")
                BorealisChip("Selected", variant: .selected)
                BorealisChip("Disabled", variant: .disabled)
            }
        }
        
        // Sizes
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Chip Sizes")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.sm) {
                BorealisChip("Small", size: .small)
                BorealisChip("Medium", size: .medium)
                BorealisChip("Large", size: .large)
            }
        }
        
        // With Icons
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Chips with Icons")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.sm) {
                BorealisChip("Leading", leadingIcon: "star.fill")
                BorealisChip("Trailing", trailingIcon: "chevron.right")
                BorealisChip("Both", leadingIcon: "tag.fill", trailingIcon: "checkmark")
            }
        }
        
        // Removable
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Removable Chips")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.sm) {
                BorealisChip("Removable", showRemoveButton: true, onRemove: {
                    print("Removed")
                })
                BorealisChip("Selected", variant: .selected, showRemoveButton: true, onRemove: {
                    print("Removed")
                })
            }
        }
        
        // Interactive
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Interactive Chips")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.sm) {
                BorealisChip("Tap Me", onTap: {
                    print("Tapped")
                })
                BorealisChip("Selected", variant: .selected, onTap: {
                    print("Tapped")
                })
            }
        }
    }
    .padding()
}
