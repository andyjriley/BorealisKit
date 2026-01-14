import SwiftUI

/// Borealis Button Component - UCM Pattern
public struct BorealisButton: View {
    public enum Variant {
        case primary
        case secondary
        case outline
        case text
    }
    
    public enum Size {
        case small
        case medium
        case large
        
        var padding: EdgeInsets {
            switch self {
            case .small:
                return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
            case .medium:
                return EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
            case .large:
                return EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32)
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small:
                return BorealisTypography.fontSizeXS
            case .medium:
                return BorealisTypography.fontSizeS
            case .large:
                return BorealisTypography.fontSizeM
            }
        }
    }
    
    let title: String
    let variant: Variant
    let size: Size
    let action: () -> Void
    
    public init(
        _ title: String,
        variant: Variant = .primary,
        size: Size = .medium,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.size = size
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: size.fontSize, weight: .semibold))
                .foregroundColor(textColor)
                .padding(size.padding)
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: BorealisRadius.md)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .cornerRadius(BorealisRadius.md)
        }
        .buttonStyle(BorealisButtonStyle())
    }
    
    private var backgroundColor: Color {
        switch variant {
        case .primary:
            return BorealisColors.primary
        case .secondary:
            return BorealisColors.surface
        case .outline, .text:
            return Color.clear
        }
    }
    
    private var textColor: Color {
        switch variant {
        case .primary:
            return .white
        case .secondary:
            return BorealisColors.primaryText
        case .outline, .text:
            return BorealisColors.primary
        }
    }
    
    private var borderColor: Color {
        switch variant {
        case .secondary:
            return BorealisColors.primaryText
        case .outline:
            return BorealisColors.primary
        default:
            return Color.clear
        }
    }
    
    private var borderWidth: CGFloat {
        (variant == .secondary || variant == .outline) ? 2 : 0
    }
}

// Custom Button Style for press animations
private struct BorealisButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: BorealisSpacing.md) {
        BorealisButton("Primary Button", variant: .primary) {}
        BorealisButton("Secondary Button", variant: .secondary) {}
        BorealisButton("Outline Button", variant: .outline) {}
        BorealisButton("Text Button", variant: .text) {}
    }
    .padding()
}
