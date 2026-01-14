import SwiftUI

// Component Type Enum
enum ComponentType: String, Identifiable, CaseIterable {
    case button = "Button"
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .button:
            return "Interactive buttons with multiple variants and sizes"
        }
    }
    
    var icon: String {
        switch self {
        case .button:
            return "button.programmable"
        }
    }
}
