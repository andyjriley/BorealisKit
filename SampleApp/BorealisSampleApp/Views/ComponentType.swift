import SwiftUI

// Component Type Enum
enum ComponentType: String, Identifiable, CaseIterable {
    case button = "Button"
    case text = "Text"
    case chip = "Chip"
    case progressIndicator = "Progress Indicator"
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .button:
            return "Interactive buttons with multiple variants and sizes"
        case .text:
            return "Styled text components with typography variants and colors"
        case .chip:
            return "Interactive tag/badge components with selection and removal"
        case .progressIndicator:
            return "Loading and progress indicators with linear and circular styles"
        }
    }
    
    var icon: String {
        switch self {
        case .button:
            return "button.programmable"
        case .text:
            return "textformat"
        case .chip:
            return "tag.fill"
        case .progressIndicator:
            return "chart.bar.fill"
        }
    }
}
