import SwiftUI

/// Borealis Card Component - UCM Pattern
public struct BorealisCard<Content: View>: View {
    let content: Content
    let padding: EdgeInsets
    let showShadow: Bool
    
    public init(
        padding: EdgeInsets = EdgeInsets(
            top: BorealisSpacing.md,
            leading: BorealisSpacing.md,
            bottom: BorealisSpacing.md,
            trailing: BorealisSpacing.md
        ),
        showShadow: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.showShadow = showShadow
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(padding)
            .background(BorealisColors.surface)
            .cornerRadius(BorealisRadius.lg)
            .shadow(
                color: showShadow ? BorealisShadow.md.color : .clear,
                radius: showShadow ? BorealisShadow.md.radius : 0,
                x: showShadow ? BorealisShadow.md.x : 0,
                y: showShadow ? BorealisShadow.md.y : 0
            )
    }
}

#Preview {
    BorealisCard {
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Card Title")
                .font(BorealisTypography.headingM())
            Text("This is a card component with some content inside.")
                .font(BorealisTypography.body())
                .foregroundColor(BorealisColors.textSecondary)
        }
    }
    .padding()
}
