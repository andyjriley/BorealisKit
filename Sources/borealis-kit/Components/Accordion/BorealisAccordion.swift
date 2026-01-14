import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

/// Borealis Accordion Variant Styles
public enum BorealisAccordionVariant {
    case defaultStyle
    case bordered
    case filled
    case minimal
}

/// Borealis Accordion Icon Position
public enum BorealisAccordionIconPosition {
    case leading
    case trailing
}

/// Borealis Accordion Chevron Position
public enum BorealisAccordionChevron {
    case left
    case right
    case none
}

/// Borealis Accordion Size Variant
public enum BorealisAccordionSize {
    case sm
    case lg
}

/// Borealis Accordion Component - UCM Pattern
public struct BorealisAccordion<Content: View>: View {
    
    let title: String
    let content: Content
    let variant: BorealisAccordionVariant
    let size: BorealisAccordionSize
    let showIcon: Bool
    let iconPosition: BorealisAccordionIconPosition
    let chevron: BorealisAccordionChevron
    let showDivider: Bool
    let spacing: CGFloat
    let animationDuration: Double
    let alignRight: Bool
    let emphasis: Bool
    @Binding var isExpanded: Bool
    
    public init(
        title: String,
        isExpanded: Binding<Bool>,
        expanded: Bool? = nil,
        variant: BorealisAccordionVariant = .defaultStyle,
        size: BorealisAccordionSize = .lg,
        showIcon: Bool = true,
        iconPosition: BorealisAccordionIconPosition = .trailing,
        chevron: BorealisAccordionChevron? = nil,
        showDivider: Bool = true,
        spacing: CGFloat? = nil,
        animationDuration: Double = 0.3,
        alignRight: Bool = false,
        emphasis: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self._isExpanded = isExpanded
        // Set initial expanded state if provided
        if let expanded = expanded {
            isExpanded.wrappedValue = expanded
        }
        self.variant = variant
        self.size = size
        self.showIcon = showIcon
        self.iconPosition = iconPosition
        // If chevron is provided, use it; otherwise derive from showIcon and iconPosition
        if let chevron = chevron {
            self.chevron = chevron
        } else {
            if showIcon {
                self.chevron = iconPosition == .leading ? .left : .right
            } else {
                self.chevron = .none
            }
        }
        self.showDivider = showDivider
        self.spacing = spacing ?? (size == .sm ? BorealisSpacing.sm : BorealisSpacing.md)
        self.animationDuration = animationDuration
        self.alignRight = alignRight
        self.emphasis = emphasis
        self.content = content()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header
            Button(action: {
                withAnimation(.easeInOut(duration: animationDuration)) {
                    isExpanded.toggle()
                }
            }) {
                HStack(spacing: spacing) {
                    if chevron == .left {
                        iconView
                    }
                    
                    Text(title)
                        .font(emphasis ? BorealisTypography.headingM() : (size == .sm ? BorealisTypography.bodySmall() : BorealisTypography.body()))
                        .fontWeight(emphasis ? .semibold : .regular)
                        .foregroundColor(BorealisColors.textPrimary)
                        .frame(maxWidth: .infinity, alignment: alignRight ? .trailing : .leading)
                    
                    if chevron == .right {
                        iconView
                    }
                }
                .padding(padding)
                .background(headerBackgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .cornerRadius(cornerRadius)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Content
            if isExpanded {
                VStack(spacing: 0) {
                    if showDivider {
                        Divider()
                            .background(BorealisColors.border)
                    }
                    
                    content
                        .padding(padding)
                        .background(contentBackgroundColor)
                        .clipShape(
                            RoundedCorner(radius: cornerRadius, corners: [.bottomLeft, .bottomRight])
                        )
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(containerBackgroundColor)
        .cornerRadius(cornerRadius)
        .shadow(
            color: shadowColor,
            radius: shadowRadius,
            x: 0,
            y: shadowY
        )
    }
    
    private var iconView: some View {
        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
            .font(.system(size: size == .sm ? 12 : 14, weight: .semibold))
            .foregroundColor(BorealisColors.textSecondary)
            .animation(.easeInOut(duration: animationDuration), value: isExpanded)
    }
    
    private var padding: EdgeInsets {
        let verticalPadding = size == .sm ? BorealisSpacing.sm : BorealisSpacing.md
        let horizontalPadding = size == .sm ? BorealisSpacing.sm : BorealisSpacing.md
        return EdgeInsets(
            top: verticalPadding,
            leading: horizontalPadding,
            bottom: verticalPadding,
            trailing: horizontalPadding
        )
    }
    
    private var cornerRadius: CGFloat {
        switch variant {
        case .defaultStyle, .bordered:
            return BorealisRadius.md
        case .filled:
            return BorealisRadius.lg
        case .minimal:
            return BorealisRadius.none
        }
    }
    
    private var headerBackgroundColor: Color {
        let baseColor: Color
        switch variant {
        case .defaultStyle:
            baseColor = BorealisColors.surface
        case .bordered:
            baseColor = BorealisColors.surface
        case .filled:
            baseColor = BorealisColors.background
        case .minimal:
            baseColor = Color.clear
        }
        
        // Apply emphasis styling
        if emphasis && variant != .minimal {
            return baseColor.opacity(0.95)
        }
        return baseColor
    }
    
    private var contentBackgroundColor: Color {
        switch variant {
        case .defaultStyle, .bordered:
            return BorealisColors.surface
        case .filled:
            return BorealisColors.background
        case .minimal:
            return Color.clear
        }
    }
    
    private var containerBackgroundColor: Color {
        switch variant {
        case .defaultStyle, .bordered, .filled:
            return BorealisColors.surface
        case .minimal:
            return Color.clear
        }
    }
    
    private var borderColor: Color {
        switch variant {
        case .defaultStyle, .minimal:
            return Color.clear
        case .bordered:
            return BorealisColors.border
        case .filled:
            return Color.clear
        }
    }
    
    private var borderWidth: CGFloat {
        switch variant {
        case .bordered:
            return 1
        default:
            return 0
        }
    }
    
    private var shadowColor: Color {
        switch variant {
        case .defaultStyle, .bordered, .filled:
            return BorealisShadow.sm.color
        case .minimal:
            return .clear
        }
    }
    
    private var shadowRadius: CGFloat {
        switch variant {
        case .defaultStyle, .bordered, .filled:
            return BorealisShadow.sm.radius
        case .minimal:
            return 0
        }
    }
    
    private var shadowY: CGFloat {
        switch variant {
        case .defaultStyle, .bordered, .filled:
            return BorealisShadow.sm.y
        case .minimal:
            return 0
        }
    }
}

// Platform-agnostic corner type
public struct RectCorner: OptionSet {
    public let rawValue: UInt
    public static let topLeft = RectCorner(rawValue: 1 << 0)
    public static let topRight = RectCorner(rawValue: 1 << 1)
    public static let bottomLeft = RectCorner(rawValue: 1 << 2)
    public static let bottomRight = RectCorner(rawValue: 1 << 3)
    public static let allCorners: RectCorner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

// Extension for corner radius on specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: RectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

private struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: RectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let topLeft = corners.contains(.topLeft)
        let topRight = corners.contains(.topRight)
        let bottomLeft = corners.contains(.bottomLeft)
        let bottomRight = corners.contains(.bottomRight)
        
        let topLeftRadius = topLeft ? radius : 0
        let topRightRadius = topRight ? radius : 0
        let bottomLeftRadius = bottomLeft ? radius : 0
        let bottomRightRadius = bottomRight ? radius : 0
        
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY))
        if topRight {
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + topRightRadius),
                            control: CGPoint(x: rect.maxX, y: rect.minY))
        } else {
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        }
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRightRadius))
        if bottomRight {
            path.addQuadCurve(to: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY),
                            control: CGPoint(x: rect.maxX, y: rect.maxY))
        } else {
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }
        path.addLine(to: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY))
        if bottomLeft {
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - bottomLeftRadius),
                            control: CGPoint(x: rect.minX, y: rect.maxY))
        } else {
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeftRadius))
        if topLeft {
            path.addQuadCurve(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY),
                            control: CGPoint(x: rect.minX, y: rect.minY))
        } else {
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        }
        path.closeSubpath()
        return path
    }
}

/// Accordion Group - Manages multiple accordion items
public struct BorealisAccordionGroup<Content: View>: View {
    public enum ExpansionMode {
        case single  // Only one item can be expanded at a time
        case multiple  // Multiple items can be expanded simultaneously
    }
    
    let items: [AccordionItem]
    let expansionMode: ExpansionMode
    let variant: BorealisAccordionVariant
    let size: BorealisAccordionSize
    let showIcon: Bool
    let iconPosition: BorealisAccordionIconPosition
    let chevron: BorealisAccordionChevron
    let showDivider: Bool
    let spacing: CGFloat
    let animationDuration: Double
    let alignRight: Bool
    let emphasis: Bool
    let grouped: Bool
    let contentBuilder: (AccordionItem) -> Content
    
    @State private var expandedIndices: Set<Int> = []
    
    // Initializer for items with content builder
    public init(
        items: [AccordionItem],
        expansionMode: ExpansionMode = .single,
        variant: BorealisAccordionVariant = .defaultStyle,
        size: BorealisAccordionSize = .lg,
        showIcon: Bool = true,
        iconPosition: BorealisAccordionIconPosition = .trailing,
        chevron: BorealisAccordionChevron? = nil,
        showDivider: Bool = true,
        spacing: CGFloat? = nil,
        animationDuration: Double = 0.3,
        alignRight: Bool = false,
        emphasis: Bool = false,
        grouped: Bool = true,
        @ViewBuilder content: @escaping (AccordionItem) -> Content
    ) {
        self.items = items
        self.expansionMode = expansionMode
        self.variant = variant
        self.size = size
        self.showIcon = showIcon
        self.iconPosition = iconPosition
        if let chevron = chevron {
            self.chevron = chevron
        } else {
            if showIcon {
                self.chevron = iconPosition == .leading ? .left : .right
            } else {
                self.chevron = .none
            }
        }
        self.showDivider = showDivider
        self.spacing = spacing ?? (size == .sm ? BorealisSpacing.sm : BorealisSpacing.md)
        self.animationDuration = animationDuration
        self.alignRight = alignRight
        self.emphasis = emphasis
        self.grouped = grouped
        self.contentBuilder = content
    }
    
    public var body: some View {
        VStack(spacing: grouped ? spacing : 0) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    BorealisAccordion(
                        title: item.title,
                        isExpanded: Binding(
                            get: { expandedIndices.contains(index) },
                            set: { isExpanded in
                                if isExpanded {
                                    if expansionMode == .single {
                                        expandedIndices = [index]
                                    } else {
                                        var newIndices = expandedIndices
                                        newIndices.insert(index)
                                        expandedIndices = newIndices
                                    }
                                } else {
                                    var newIndices = expandedIndices
                                    newIndices.remove(index)
                                    expandedIndices = newIndices
                                }
                            }
                        ),
                        variant: variant,
                        size: size,
                        showIcon: showIcon,
                        iconPosition: iconPosition,
                        chevron: chevron,
                        showDivider: showDivider,
                        spacing: spacing,
                        animationDuration: animationDuration,
                        alignRight: alignRight,
                        emphasis: emphasis
                    ) {
                        contentBuilder(item)
                    }
                }
            
        }
    }
}

/// Accordion Item Data Model
public struct AccordionItem: Identifiable {
    public let id: UUID
    public let title: String
    public let data: [String: Any]? // For JSON Rich Text Editor data
    
    public init(id: UUID = UUID(), title: String, data: [String: Any]? = nil) {
        self.id = id
        self.title = title
        self.data = data
    }
}

/// Headline Model (UCM) - Used across Accordion and Card components
public struct Headline {
    public let small: String
    public let large: String
    
    public init(small: String, large: String) {
        self.small = small
        self.large = large
    }
}

/// Description Model (UCM) - Used across Accordion and Card components
public struct Description {
    public let small: String
    public let large: String // May contain HTML
    
    public init(small: String, large: String) {
        self.small = small
        self.large = large
    }
}


#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var expanded1 = false
    @State private var expanded2 = false
    @State private var expanded3 = false
    
    let items = [
        AccordionItem(title: "Section 1"),
        AccordionItem(title: "Section 2"),
        AccordionItem(title: "Section 3")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: BorealisSpacing.lg) {
                // Single Accordion Examples
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Default Style")
                        .font(BorealisTypography.headingM())
                    
                    BorealisAccordion(
                        title: "Click to expand",
                        isExpanded: $expanded1
                    ) {
                        Text("This is the content of the accordion. It can contain any SwiftUI view.")
                            .font(BorealisTypography.body())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
                
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Bordered Style")
                        .font(BorealisTypography.headingM())
                    
                    BorealisAccordion(
                        title: "Bordered Accordion",
                        isExpanded: $expanded2,
                        variant: .bordered
                    ) {
                        VStack(alignment: .leading, spacing: BorealisSpacing.sm) {
                            Text("Content with multiple lines")
                            Text("And more content here")
                        }
                        .font(BorealisTypography.body())
                        .foregroundColor(BorealisColors.textSecondary)
                    }
                }
                
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Filled Style")
                        .font(BorealisTypography.headingM())
                    
                    BorealisAccordion(
                        title: "Filled Accordion",
                        isExpanded: $expanded3,
                        variant: .filled
                    ) {
                        Text("Filled variant content")
                            .font(BorealisTypography.body())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
                
                // Accordion Group Example
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Accordion Group (Single Expansion)")
                        .font(BorealisTypography.headingM())
                    
                    BorealisAccordionGroup(
                        items: items,
                        expansionMode: .single
                    ) { item in
                        Text("Content for \(item.title)")
                            .font(BorealisTypography.body())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
                
                // Accordion Group with Multiple Expansion
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Accordion Group (Multiple Expansion)")
                        .font(BorealisTypography.headingM())
                    
                    BorealisAccordionGroup(
                        items: items,
                        expansionMode: .multiple
                    ) { item in
                        Text("Content for \(item.title)")
                            .font(BorealisTypography.body())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
            }
            .padding()
        }
    }
}
