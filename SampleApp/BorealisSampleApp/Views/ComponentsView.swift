import SwiftUI
import BorealisKit

struct ComponentsView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(ComponentType.allCases) { component in
                    NavigationLink(destination: ComponentDetailView(componentType: component)) {
                        HStack(spacing: BorealisSpacing.md) {
                            Image(systemName: component.icon)
                                .font(.system(size: 20))
                                .foregroundColor(BorealisColors.primary)
                                .frame(width: 30)
                            
                            VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                                Text(component.rawValue)
                                    .font(BorealisTypography.headingM())
                                    .foregroundColor(BorealisColors.textPrimary)
                                
                                Text(component.description)
                                    .font(BorealisTypography.bodySmall())
                                    .foregroundColor(BorealisColors.textSecondary)
                            }
                        }
                        .padding(.vertical, BorealisSpacing.xs)
                    }
                }
            }
            .navigationTitle("Components")
            .background(BorealisColors.background)
        }
    }
}
