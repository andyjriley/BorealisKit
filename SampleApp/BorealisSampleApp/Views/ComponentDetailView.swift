import SwiftUI
import BorealisKit

// Component Detail View
struct ComponentDetailView: View {
    let componentType: ComponentType
    
    var body: some View {
        ScrollView {
            VStack(spacing: BorealisSpacing.xl) {
                // Header
                VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                    Text(componentType.rawValue)
                        .font(BorealisTypography.headingXL())
                    
                    Text(componentType.description)
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Component Content
                componentContent
            }
            .padding(BorealisSpacing.lg)
        }
        .navigationTitle(componentType.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .background(BorealisColors.background)
    }
    
    @ViewBuilder
    private var componentContent: some View {
        switch componentType {
        case .button:
            ButtonComponentContent()
        case .text:
            TextComponentContent()
        case .chip:
            ChipComponentContent()
        case .progressIndicator:
            ProgressIndicatorComponentContent()
        }
    }
}
