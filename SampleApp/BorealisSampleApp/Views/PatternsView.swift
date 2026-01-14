import SwiftUI
import BorealisKit

struct PatternsView: View {

    var body: some View {
        NavigationView {
            List {
                ForEach(PatternType.allCases) { pattern in
                    NavigationLink(destination: PatternDetailView(patternType: pattern)) {
                        HStack(spacing: BorealisSpacing.md) {
                            Image(systemName: pattern.icon)
                                .font(.system(size: 20))
                                .foregroundColor(BorealisColors.primary)
                                .frame(width: 30)
                            
                            VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                                Text(pattern.rawValue)
                                    .font(BorealisTypography.headingM())
                                    .foregroundColor(BorealisColors.textPrimary)
                                
                                Text(pattern.description)
                                    .font(BorealisTypography.bodySmall())
                                    .foregroundColor(BorealisColors.textSecondary)
                            }
                        }
                        .padding(.vertical, BorealisSpacing.xs)
                    }
                }
            }
            .navigationTitle("UCM Patterns")
            .background(BorealisColors.background)
        }
    }
}
