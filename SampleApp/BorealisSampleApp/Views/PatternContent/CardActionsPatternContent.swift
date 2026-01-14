import SwiftUI
import BorealisKit

struct CardActionsPatternContent: View {
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        Text("Card with Actions")
                            .font(BorealisTypography.headingM())
                        Text("Cards can contain multiple interactive elements")
                            .font(BorealisTypography.bodySmall())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                    
                    HStack(spacing: BorealisSpacing.md) {
                        BorealisButton("Action", variant: .outline, size: .small) {}
                        BorealisButton("Primary", variant: .primary, size: .small) {}
                    }
                }
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Pattern Description")
                        .font(BorealisTypography.headingM())
                    
                    Text("This pattern combines cards with action buttons. It's useful for displaying actionable content.")
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
