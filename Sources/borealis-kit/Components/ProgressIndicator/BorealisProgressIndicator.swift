import SwiftUI

/// Borealis Progress Indicator Component - Loading and progress indicators
public struct BorealisProgressIndicator: View {
    public enum Style {
        case linear
        case circular
    }
    
    public enum Variant {
        case primary
        case secondary
        case success
        case warning
        case error
        case info
        
        var color: Color {
            switch self {
            case .primary:
                return BorealisColors.primary
            case .secondary:
                return BorealisColors.secondary
            case .success:
                return BorealisColors.success
            case .warning:
                return BorealisColors.warning
            case .error:
                return BorealisColors.error
            case .info:
                return BorealisColors.info
            }
        }
    }
    
    public enum Size {
        case small
        case medium
        case large
        
        var linearHeight: CGFloat {
            switch self {
            case .small:
                return 4
            case .medium:
                return 6
            case .large:
                return 8
            }
        }
        
        var circularSize: CGFloat {
            switch self {
            case .small:
                return 20
            case .medium:
                return 32
            case .large:
                return 48
            }
        }
        
        var strokeWidth: CGFloat {
            switch self {
            case .small:
                return 2
            case .medium:
                return 3
            case .large:
                return 4
            }
        }
    }
    
    let style: Style
    let variant: Variant
    let size: Size
    let progress: Double? // 0.0 to 1.0, nil for indeterminate
    let showLabel: Bool
    let label: String?
    
    public init(
        style: Style = .linear,
        variant: Variant = .primary,
        size: Size = .medium,
        progress: Double? = nil,
        showLabel: Bool = false,
        label: String? = nil
    ) {
        self.style = style
        self.variant = variant
        self.size = size
        self.progress = progress
        self.showLabel = showLabel
        self.label = label
    }
    
    public var body: some View {
        Group {
            switch style {
            case .linear:
                linearProgress
            case .circular:
                circularProgress
            }
        }
    }
    
    // MARK: - Linear Progress
    
    private var linearProgress: some View {
        VStack(spacing: BorealisSpacing.xs) {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    RoundedRectangle(cornerRadius: BorealisRadius.full)
                        .fill(variant.color.opacity(0.2))
                        .frame(height: size.linearHeight)
                    
                    // Progress bar
                    if let progress = progress {
                        // Determinate progress
                        RoundedRectangle(cornerRadius: BorealisRadius.full)
                            .fill(variant.color)
                            .frame(width: geometry.size.width * CGFloat(min(max(progress, 0), 1)), height: size.linearHeight)
                            .animation(.easeInOut(duration: 0.3), value: progress)
                    } else {
                        // Indeterminate progress (animated)
                        IndeterminateLinearProgress(color: variant.color, height: size.linearHeight)
                    }
                }
            }
            .frame(height: size.linearHeight)
            
            // Label
            if showLabel, let label = label {
                Text(label)
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.textSecondary)
            } else if showLabel, let progress = progress {
                Text("\(Int(progress * 100))%")
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.textSecondary)
            }
        }
    }
    
    // MARK: - Circular Progress
    
    private var circularProgress: some View {
        VStack(spacing: BorealisSpacing.xs) {
            ZStack {
                if let progress = progress {
                    // Determinate circular progress
                    Circle()
                        .stroke(variant.color.opacity(0.2), lineWidth: size.strokeWidth)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(min(max(progress, 0), 1)))
                        .stroke(
                            variant.color,
                            style: StrokeStyle(lineWidth: size.strokeWidth, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.3), value: progress)
                    
                    if showLabel {
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: size == .small ? 8 : (size == .medium ? 10 : 12), weight: .semibold))
                            .foregroundColor(BorealisColors.textPrimary)
                    }
                } else {
                    // Indeterminate circular progress (spinner)
                    Circle()
                        .stroke(variant.color.opacity(0.2), lineWidth: size.strokeWidth)
                    
                    IndeterminateCircularProgress(color: variant.color, strokeWidth: size.strokeWidth)
                }
            }
            .frame(width: size.circularSize, height: size.circularSize)
            
            // Label below circular progress
            if showLabel, let label = label, progress == nil {
                Text(label)
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.textSecondary)
            }
        }
    }
}

// MARK: - Indeterminate Linear Progress

private struct IndeterminateLinearProgress: View {
    let color: Color
    let height: CGFloat
    @State private var offset: CGFloat = -1
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: BorealisRadius.full)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            color.opacity(0.3),
                            color,
                            color.opacity(0.3)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: geometry.size.width * 0.4, height: height)
                .offset(x: offset * geometry.size.width)
                .onAppear {
                    withAnimation(
                        Animation.linear(duration: 1.5)
                            .repeatForever(autoreverses: false)
                    ) {
                        offset = 1.4
                    }
                }
        }
    }
}

// MARK: - Indeterminate Circular Progress

private struct IndeterminateCircularProgress: View {
    let color: Color
    let strokeWidth: CGFloat
    @State private var rotation: Double = 0
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.7)
            .stroke(
                color,
                style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
            )
            .rotationEffect(.degrees(rotation))
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.0)
                        .repeatForever(autoreverses: false)
                ) {
                    rotation = 360
                }
            }
    }
}

#Preview {
    VStack(spacing: BorealisSpacing.xl) {
        // Linear Progress - Determinate
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Linear Progress - Determinate")
                .font(BorealisTypography.headingM())
            
            BorealisProgressIndicator(
                style: .linear,
                progress: 0.3,
                showLabel: true
            )
            
            BorealisProgressIndicator(
                style: .linear,
                progress: 0.6,
                showLabel: true
            )
            
            BorealisProgressIndicator(
                style: .linear,
                progress: 0.9,
                showLabel: true
            )
        }
        
        // Linear Progress - Indeterminate
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Linear Progress - Indeterminate")
                .font(BorealisTypography.headingM())
            
            BorealisProgressIndicator(style: .linear)
            BorealisProgressIndicator(style: .linear, showLabel: true, label: "Loading...")
        }
        
        // Circular Progress - Determinate
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Circular Progress - Determinate")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.lg) {
                BorealisProgressIndicator(
                    style: .circular,
                    progress: 0.3,
                    showLabel: true
                )
                
                BorealisProgressIndicator(
                    style: .circular,
                    progress: 0.6,
                    showLabel: true
                )
                
                BorealisProgressIndicator(
                    style: .circular,
                    progress: 0.9,
                    showLabel: true
                )
            }
        }
        
        // Circular Progress - Indeterminate
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Circular Progress - Indeterminate")
                .font(BorealisTypography.headingM())
            
            HStack(spacing: BorealisSpacing.lg) {
                BorealisProgressIndicator(style: .circular)
                BorealisProgressIndicator(style: .circular, showLabel: true, label: "Loading...")
            }
        }
        
        // Variants
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Color Variants")
                .font(BorealisTypography.headingM())
            
            VStack(spacing: BorealisSpacing.sm) {
                BorealisProgressIndicator(style: .linear, variant: .primary, progress: 0.5)
                BorealisProgressIndicator(style: .linear, variant: .success, progress: 0.5)
                BorealisProgressIndicator(style: .linear, variant: .warning, progress: 0.5)
                BorealisProgressIndicator(style: .linear, variant: .error, progress: 0.5)
            }
        }
        
        // Sizes
        VStack(alignment: .leading, spacing: BorealisSpacing.md) {
            Text("Sizes")
                .font(BorealisTypography.headingM())
            
            VStack(spacing: BorealisSpacing.sm) {
                BorealisProgressIndicator(style: .linear, size: .small, progress: 0.5)
                BorealisProgressIndicator(style: .linear, size: .medium, progress: 0.5)
                BorealisProgressIndicator(style: .linear, size: .large, progress: 0.5)
            }
        }
    }
    .padding()
}
