import SwiftUI
import BorealisKit

struct AlertPatternContent: View {
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Default
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Default")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Displays a default alert.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAlert(
                    type: .default,
                    description: "<html><p>Alert copy goes here</p></html>"
                )
            }
            
            // Info type
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Info type")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Displays an alert with an information type.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAlert(
                    type: .info,
                    description: "<html><p>Alert copy goes here</p></html>"
                )
            }
            
            // Success type
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Success type")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Displays a success alert.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAlert(
                    type: .success,
                    description: "<html><p>Alert copy goes here</p></html>"
                )
            }
            
            // Warning type
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Warning type")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Displays a warning alert.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAlert(
                    type: .warning,
                    description: "<html><p>Alert copy goes here</p></html>"
                )
            }
            
            // Error type
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Error type")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Displays an error alert.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAlert(
                    type: .error,
                    description: "<html><p>Alert copy goes here</p></html>"
                )
            }
            
            // With action link
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Alert with Action Link")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Alerts can include action links for additional information.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                BorealisAlert(
                    type: .info,
                    description: "<html><p>Alert copy goes here</p></html>",
                    action: AlertAction(
                        link: AlertLink(
                            href: "https://www.portseattle.org/sea-tac",
                            title: "Learn More"
                        )
                    )
                )
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("All Props Available")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • type: Alert type (default, error, warning, information, success)
                    • description: HTML content for the alert message
                    • action: Optional action link (href, title)
                    • customContent: Optional JSON Generic Text Renderer data
                    • hidden: Boolean to hide/show the alert (default: false)
                    • hasCustomContent: Boolean to show/hide custom content (default: false)
                    • showIcon: Boolean to show/hide the icon (default: true)
                    
                    Icon Details:
                    - Default: No icon
                    - Info/Information: Circular blue background with white 'i'
                    - Success: Circular green background with white checkmark
                    - Warning: Circular yellow-orange background with white exclamation mark
                    - Error: Triangular red background with white exclamation mark
                    
                    Styling:
                    - All alerts have a white background.
                    - A 1pt solid border matching the alert type's color.
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
