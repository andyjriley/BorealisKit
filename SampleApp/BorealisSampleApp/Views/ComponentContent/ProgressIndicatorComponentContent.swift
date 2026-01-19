import SwiftUI
import BorealisKit

struct ProgressIndicatorComponentContent: View {
    @State private var linearProgress: Double = 0.3
    @State private var circularProgress: Double = 0.5
    @State private var animatedProgress: Double = 0.0
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            // Linear Progress - Determinate
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Linear Progress - Determinate")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Shows progress with a specific value from 0% to 100%.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.md) {
                    BorealisProgressIndicator(
                        style: .linear,
                        progress: linearProgress,
                        showLabel: true
                    )
                    
                    Slider(value: $linearProgress, in: 0...1)
                        .tint(BorealisColors.primary)
                    
                    HStack {
                        Text("0%")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                        Spacer()
                        Text("100%")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
            }
            
            // Linear Progress - Indeterminate
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Linear Progress - Indeterminate")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Animated progress bar for loading states when progress is unknown.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.sm) {
                    BorealisProgressIndicator(style: .linear)
                    BorealisProgressIndicator(style: .linear, showLabel: true, label: "Loading...")
                }
            }
            
            // Circular Progress - Determinate
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Circular Progress - Determinate")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Circular progress indicator showing specific progress value.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: BorealisSpacing.xl) {
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(
                            style: .circular,
                            progress: circularProgress,
                            showLabel: true
                        )
                        
                        Slider(value: $circularProgress, in: 0...1)
                            .tint(BorealisColors.primary)
                            .frame(width: 150)
                    }
                    
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(
                            style: .circular,
                            size: .small,
                            progress: 0.3,
                            showLabel: true
                        )
                        Text("Small")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                    
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(
                            style: .circular,
                            size: .large,
                            progress: 0.7,
                            showLabel: true
                        )
                        Text("Large")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
            }
            
            // Circular Progress - Indeterminate
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Circular Progress - Indeterminate")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Animated spinner for loading states when progress is unknown.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: BorealisSpacing.xl) {
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(style: .circular, size: .small)
                        Text("Small")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                    
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(style: .circular, size: .medium)
                        Text("Medium")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                    
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(style: .circular, size: .large)
                        Text("Large")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                    
                    VStack(spacing: BorealisSpacing.sm) {
                        BorealisProgressIndicator(
                            style: .circular,
                            showLabel: true,
                            label: "Loading..."
                        )
                        Text("With Label")
                            .font(BorealisTypography.caption())
                            .foregroundColor(BorealisColors.textSecondary)
                    }
                }
            }
            
            // Color Variants
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Color Variants")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Progress indicators support different color variants for semantic meaning.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.sm) {
                    BorealisProgressIndicator(
                        style: .linear,
                        variant: .primary,
                        progress: 0.5
                    )
                    BorealisProgressIndicator(
                        style: .linear,
                        variant: .success,
                        progress: 0.5
                    )
                    BorealisProgressIndicator(
                        style: .linear,
                        variant: .warning,
                        progress: 0.5
                    )
                    BorealisProgressIndicator(
                        style: .linear,
                        variant: .error,
                        progress: 0.5
                    )
                    BorealisProgressIndicator(
                        style: .linear,
                        variant: .info,
                        progress: 0.5
                    )
                }
            }
            
            // Sizes
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Sizes")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Progress indicators are available in three sizes: small, medium (default), and large.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.sm) {
                    BorealisProgressIndicator(
                        style: .linear,
                        size: .small,
                        progress: 0.5
                    )
                    BorealisProgressIndicator(
                        style: .linear,
                        size: .medium,
                        progress: 0.5
                    )
                    BorealisProgressIndicator(
                        style: .linear,
                        size: .large,
                        progress: 0.5
                    )
                }
            }
            
            // Animated Progress Example
            VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                Text("Animated Progress Example")
                    .font(BorealisTypography.headingM())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Example of progress indicator with animated value updates.")
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: BorealisSpacing.sm) {
                    BorealisProgressIndicator(
                        style: .linear,
                        progress: animatedProgress,
                        showLabel: true
                    )
                    
                    BorealisProgressIndicator(
                        style: .circular,
                        progress: animatedProgress,
                        showLabel: true
                    )
                    
                    Button("Start Animation") {
                        withAnimation(.linear(duration: 3)) {
                            animatedProgress = 1.0
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            animatedProgress = 0.0
                        }
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            BorealisCard {
                VStack(alignment: .leading, spacing: BorealisSpacing.md) {
                    Text("Progress Indicator Component Props")
                        .font(BorealisTypography.headingM())
                    
                    Text("""
                    • style: Progress style (linear, circular)
                    • variant: Color variant (primary, secondary, success, warning, error, info)
                    • size: Indicator size (small, medium, large)
                    • progress: Optional progress value (0.0 to 1.0), nil for indeterminate
                    • showLabel: Boolean to show progress label or percentage
                    • label: Optional custom label text
                    
                    Style Details:
                    - linear: Horizontal progress bar
                    - circular: Circular/spinner progress indicator
                    
                    Progress Types:
                    - Determinate: Set progress value (0.0 to 1.0) to show specific progress
                    - Indeterminate: Set progress to nil for animated loading state
                    
                    Variant Details:
                    - primary: Primary brand color
                    - secondary: Secondary color
                    - success: Green for successful operations
                    - warning: Orange/yellow for warnings
                    - error: Red for errors
                    - info: Blue for informational states
                    
                    Size Details:
                    - small: Compact indicator (4pt height for linear, 20pt for circular)
                    - medium: Default size (6pt height for linear, 32pt for circular)
                    - large: Larger indicator (8pt height for linear, 48pt for circular)
                    
                    Use Cases:
                    - File upload/download progress
                    - Form submission loading
                    - Data loading states
                    - Background task progress
                    - Indeterminate loading spinners
                    """)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textSecondary)
                }
            }
        }
    }
}
