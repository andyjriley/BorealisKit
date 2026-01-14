import SwiftUI

/// Alert Action Model (UCM)
public struct AlertAction {
    public let link: AlertLink
    
    public init(link: AlertLink) {
        self.link = link
    }
}

/// Alert Link Model (UCM)
public struct AlertLink {
    public let href: String
    public let title: String?
    
    public init(href: String, title: String? = nil) {
        self.href = href
        self.title = title
    }
}

/// Borealis Alert Component - UCM Pattern
public struct BorealisAlert: View {
    public enum AlertType {
        case `default`
        case success
        case warning
        case error
        case info
        case information // Alias for info
        
        var icon: String? {
            switch self {
            case .default:
                return nil
            case .success:
                return "checkmark"
            case .warning:
                return "exclamationmark"
            case .error:
                return "exclamationmark"
            case .info, .information:
                return "i"
            }
        }
        
        var iconShape: IconShape {
            switch self {
            case .default:
                return .none
            case .error:
                return .triangle
            default:
                return .circle
            }
        }
        
        var color: Color {
            switch self {
            case .default:
                return BorealisColors.border
            case .success:
                return BorealisColors.success
            case .warning:
                return BorealisColors.warning
            case .error:
                return BorealisColors.error
            case .info, .information:
                return BorealisColors.info
            }
        }
    }
    
    enum IconShape {
        case none
        case circle
        case triangle
    }
    
    let type: AlertType
    let description: String // HTML content
    let action: AlertAction?
    let customContent: [[String: Any]]? // JSON RTE data
    let hidden: Bool
    let hasCustomContent: Bool
    let showIcon: Bool
    
    public init(
        type: AlertType = .default,
        description: String,
        action: AlertAction? = nil,
        customContent: [[String: Any]]? = nil,
        hidden: Bool = false,
        hasCustomContent: Bool = false,
        showIcon: Bool = true
    ) {
        self.type = type
        self.description = description
        self.action = action
        self.customContent = customContent
        self.hidden = hidden
        self.hasCustomContent = hasCustomContent
        self.showIcon = showIcon
    }
    
    // Legacy initializer for backward compatibility
    public init(
        type: AlertType,
        title: String,
        message: String? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.type = type
        // Combine title and message for description
        if let message = message {
            self.description = "<html><p>\(title)</p><p>\(message)</p></html>"
        } else {
            self.description = "<html><p>\(title)</p></html>"
        }
        self.action = nil
        self.customContent = nil
        self.hidden = false
        self.hasCustomContent = false
        self.showIcon = true
    }
    
    public var body: some View {
        // Hide component if hidden is true
        if hidden {
            EmptyView()
        } else {
            HStack(alignment: .top, spacing: BorealisSpacing.md) {
                // Icon (if showIcon is true and type has an icon)
                if showIcon, let iconName = type.icon {
                    iconView(iconName: iconName, shape: type.iconShape)
                }
                
                // Content
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    // Description text
                    Text(stripHTMLTags(from: description))
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    // Action link (if provided)
                    if let action = action {
                        Link(destination: URL(string: action.link.href) ?? URL(string: "#")!) {
                            HStack(spacing: BorealisSpacing.xs) {
                                Text(action.link.title ?? "Learn More")
                                    .font(BorealisTypography.body())
                                Image(systemName: "arrow.up.right")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(BorealisColors.primary)
                        }
                    }
                    
                    // Custom content (JSON RTE) - only show if hasCustomContent is true
                    if hasCustomContent, let customContent = customContent {
                        ForEach(Array(customContent.enumerated()), id: \.offset) { _, item in
                            if let jsonRTE = item["json_rte"] as? [String: Any] {
                                renderJSONRTE(jsonRTE)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding(BorealisSpacing.md)
            .background(BorealisColors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: BorealisRadius.md)
                    .stroke(type.color, lineWidth: 1)
            )
            .cornerRadius(BorealisRadius.md)
        }
    }
    
    // MARK: - Icon View
    
    @ViewBuilder
    private func iconView(iconName: String, shape: IconShape) -> some View {
        switch shape {
        case .none:
            EmptyView()
        case .circle:
            ZStack {
                Circle()
                    .fill(type.color)
                    .frame(width: 24, height: 24)
                
                if iconName == "i" {
                    // Use text for lowercase 'i' as shown in design
                    Text(iconName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    // Use SF Symbol for checkmark and exclamation mark
                    Image(systemName: iconName == "checkmark" ? "checkmark" : "exclamationmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        case .triangle:
            ZStack {
                Triangle()
                    .fill(type.color)
                    .frame(width: 24, height: 24)
                
                Image(systemName: "exclamationmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
    
    // MARK: - JSON RTE Renderer
    
    @ViewBuilder
    private func renderJSONRTE(_ jsonRTE: [String: Any]) -> some View {
        if let children = jsonRTE["children"] as? [[String: Any]] {
            VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                ForEach(Array(children.enumerated()), id: \.offset) { _, child in
                    renderJSONRTEChild(child)
                }
            }
        }
    }
    
    @ViewBuilder
    private func renderJSONRTEChild(_ child: [String: Any]) -> some View {
        if let type = child["type"] as? String {
            switch type {
            case "h1", "h2", "h3":
                if let text = extractText(from: child) {
                    Text(text)
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                }
            case "p":
                if let text = extractText(from: child) {
                    Text(text)
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textPrimary)
                }
            case "ul":
                if let listItems = child["children"] as? [[String: Any]] {
                    VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                        ForEach(Array(listItems.enumerated()), id: \.offset) { _, item in
                            if let itemText = extractText(from: item) {
                                HStack(alignment: .top, spacing: BorealisSpacing.xs) {
                                    Text("•")
                                        .foregroundColor(BorealisColors.textSecondary)
                                    Text(itemText)
                                        .font(BorealisTypography.body())
                                        .foregroundColor(BorealisColors.textPrimary)
                                }
                            }
                        }
                    }
                }
            default:
                if let text = extractText(from: child) {
                    Text(text)
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textPrimary)
                }
            }
        }
    }
    
    private func extractText(from node: [String: Any]) -> String? {
        if let text = node["text"] as? String {
            return text
        }
        
        if let children = node["children"] as? [[String: Any]] {
            return children.compactMap { extractText(from: $0) }.joined(separator: "")
        }
        
        return nil
    }
    
    // MARK: - Helpers
    
    private func stripHTMLTags(from html: String) -> String {
        let pattern = "<[^>]+>"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: html.utf16.count)
        let htmlFree = regex?.stringByReplacingMatches(in: html, options: [], range: range, withTemplate: "")
        
        let decoded = htmlFree?
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&amp;", with: "&")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&#39;", with: "'")
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        return decoded ?? html
    }
}

// MARK: - Triangle Shape

private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Preview

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    var body: some View {
        ScrollView {
            VStack(spacing: BorealisSpacing.lg) {
                // Default
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("Default")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    Text("Displays a default alert.")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    BorealisAlert(
                        type: .default,
                        description: "<html><p>Alert copy goes here</p></html>"
                    )
                }
                
                // Info type
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("Info type")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    Text("Displays an alert with an information type.")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    BorealisAlert(
                        type: .info,
                        description: "<html><p>Alert copy goes here</p></html>"
                    )
                }
                
                // Success type
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("Success type")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    Text("Displays a success alert.")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    BorealisAlert(
                        type: .success,
                        description: "<html><p>Alert copy goes here</p></html>"
                    )
                }
                
                // Warning type
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("Warning type")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    Text("Displays a warning alert.")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    BorealisAlert(
                        type: .warning,
                        description: "<html><p>Alert copy goes here</p></html>"
                    )
                }
                
                // Error type
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("Error type")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    Text("Displays an error alert.")
                        .font(BorealisTypography.bodySmall())
                        .foregroundColor(BorealisColors.textSecondary)
                    
                    BorealisAlert(
                        type: .error,
                        description: "<html><p>Alert copy goes here</p></html>"
                    )
                }
                
                // With action link
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
                
                // With showIcon enabled
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("With showIcon enabled")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    BorealisAlert(
                        type: .success,
                        description: "<html><p>Alert copy goes here</p></html>",
                        showIcon: true
                    )
                }
                
                // Information type (alias for info)
                VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
                    Text("Information type")
                        .font(BorealisTypography.headingM())
                        .foregroundColor(BorealisColors.textPrimary)
                    
                    BorealisAlert(
                        type: .information,
                        description: "<html><p>Alert copy goes here</p></html>",
                        showIcon: true
                    )
                }
            }
            .padding()
        }
    }
}
