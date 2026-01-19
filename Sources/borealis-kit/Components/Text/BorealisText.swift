import SwiftUI

/// Borealis Text Component - Styled text with variants and sizes
public struct BorealisText: View {
    public enum Variant {
        case headingXL
        case headingL
        case headingM
        case body
        case bodySmall
        case caption
        
        var font: Font {
            switch self {
            case .headingXL:
                return BorealisTypography.headingXL()
            case .headingL:
                return BorealisTypography.headingL()
            case .headingM:
                return BorealisTypography.headingM()
            case .body:
                return BorealisTypography.body()
            case .bodySmall:
                return BorealisTypography.bodySmall()
            case .caption:
                return BorealisTypography.caption()
            }
        }
    }
    
    public enum ColorVariant {
        case primary
        case secondary
        case muted
        case inverse
        case success
        case warning
        case error
        case info
        case custom(Color)
        
        var color: Color {
            switch self {
            case .primary:
                return BorealisColors.textPrimary
            case .secondary:
                return BorealisColors.textSecondary
            case .muted:
                return BorealisColors.textSecondary.opacity(0.7)
            case .inverse:
                return .white
            case .success:
                return BorealisColors.success
            case .warning:
                return BorealisColors.warning
            case .error:
                return BorealisColors.error
            case .info:
                return BorealisColors.info
            case .custom(let color):
                return color
            }
        }
    }
    
    public enum Weight {
        case regular
        case semibold
        case bold
        
        var fontWeight: Font.Weight {
            switch self {
            case .regular:
                return .regular
            case .semibold:
                return .semibold
            case .bold:
                return .bold
            }
        }
    }
    
    let content: String
    let variant: Variant
    let colorVariant: ColorVariant
    let weight: Weight
    let alignment: TextAlignment
    let lineLimit: Int?
    let multilineTextAlignment: TextAlignment
    
    public init(
        _ content: String,
        variant: Variant = .body,
        color: ColorVariant = .primary,
        weight: Weight = .regular,
        alignment: TextAlignment = .leading,
        lineLimit: Int? = nil,
        multilineTextAlignment: TextAlignment = .leading
    ) {
        self.content = content
        self.variant = variant
        self.colorVariant = color
        self.weight = weight
        self.alignment = alignment
        self.lineLimit = lineLimit
        self.multilineTextAlignment = multilineTextAlignment
    }
    
    public var body: some View {
        Text(content)
            .font(variant.font)
            .fontWeight(weight.fontWeight)
            .foregroundColor(colorVariant.color)
            .multilineTextAlignment(multilineTextAlignment)
            .lineLimit(lineLimit)
            .frame(maxWidth: .infinity, alignment: alignment == .leading ? .leading : (alignment == .trailing ? .trailing : .center))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: BorealisSpacing.lg) {
        // Variants
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Text Variants")
                .font(BorealisTypography.headingM())
            
            BorealisText("Heading XL", variant: .headingXL)
            BorealisText("Heading L", variant: .headingL)
            BorealisText("Heading M", variant: .headingM)
            BorealisText("Body text", variant: .body)
            BorealisText("Body Small", variant: .bodySmall)
            BorealisText("Caption", variant: .caption)
        }
        
        // Color Variants
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Color Variants")
                .font(BorealisTypography.headingM())
            
            BorealisText("Primary text", color: .primary)
            BorealisText("Secondary text", color: .secondary)
            BorealisText("Muted text", color: .muted)
            BorealisText("Success text", color: .success)
            BorealisText("Warning text", color: .warning)
            BorealisText("Error text", color: .error)
            BorealisText("Info text", color: .info)
        }
        
        // Weights
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Font Weights")
                .font(BorealisTypography.headingM())
            
            BorealisText("Regular weight", weight: .regular)
            BorealisText("Semibold weight", weight: .semibold)
            BorealisText("Bold weight", weight: .bold)
        }
        
        // Alignment
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Text Alignment")
                .font(BorealisTypography.headingM())
            
            BorealisText("Left aligned text", alignment: .leading)
            BorealisText("Center aligned text", alignment: .center)
            BorealisText("Right aligned text", alignment: .trailing)
        }
    }
    .padding()
}
