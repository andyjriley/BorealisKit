import SwiftUI

/// Borealis Input Component - UCM Pattern
public struct BorealisInput: View {
    let title: String?
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    let errorMessage: String?
    let helperText: String?
    
    @FocusState private var isFocused: Bool
    
    public init(
        title: String? = nil,
        placeholder: String = "",
        text: Binding<String>,
        isSecure: Bool = false,
        errorMessage: String? = nil,
        helperText: String? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
        self.errorMessage = errorMessage
        self.helperText = helperText
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: BorealisSpacing.xs) {
            if let title = title {
                Text(title)
                    .font(BorealisTypography.body())
                    .foregroundColor(BorealisColors.textPrimary)
            }
            
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(BorealisTypography.body())
            .foregroundColor(BorealisColors.textPrimary)
            .padding(BorealisSpacing.md)
            .background(BorealisColors.surface)
            .overlay(
                RoundedRectangle(cornerRadius: BorealisRadius.md)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
            .cornerRadius(BorealisRadius.md)
            .focused($isFocused)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.error)
            } else if let helperText = helperText {
                Text(helperText)
                    .font(BorealisTypography.caption())
                    .foregroundColor(BorealisColors.textSecondary)
            }
        }
    }
    
    private var borderColor: Color {
        if errorMessage != nil {
            return BorealisColors.error
        } else if isFocused {
            return BorealisColors.primary
        } else {
            return BorealisColors.border
        }
    }
    
    private var borderWidth: CGFloat {
        isFocused ? 2 : 1
    }
}

#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var text1 = ""
    @State private var text2 = ""
    @State private var text3 = ""
    
    var body: some View {
        VStack(spacing: BorealisSpacing.lg) {
            BorealisInput(
                title: "Email",
                placeholder: "Enter your email",
                text: $text1
            )
            
            BorealisInput(
                title: "Password",
                placeholder: "Enter your password",
                text: $text2,
                isSecure: true
            )
            
            BorealisInput(
                title: "Error Input",
                placeholder: "This has an error",
                text: $text3,
                errorMessage: "This field is required"
            )
        }
        .padding()
    }
}
