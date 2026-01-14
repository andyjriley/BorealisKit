import SwiftUI

// Pattern Type Enum
enum PatternType: String, Identifiable, CaseIterable {
    case accordion = "Accordion"
    case accordionGroup = "Accordion Group"
    case alert = "Alert"
    case cardConcise = "Card Concise"
    case cardStandard = "Card Standard"
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .accordion:
            return "Expandable and collapsible content sections"
        case .accordionGroup:
            return "Multiple accordion items with shared behavior"
        case .alert:
            return "Provide feedback and important information to users"
        case .cardConcise:
            return "Concise cards with image, text, and hover effects"
        case .cardStandard:
            return "Standard cards with multiple layouts and configurations"
        }
    }
    
    var icon: String {
        switch self {
        case .accordion:
            return "list.bullet.rectangle"
        case .accordionGroup:
            return "list.bullet.rectangle.portrait"
        case .alert:
            return "exclamationmark.triangle"
        case .cardConcise:
            return "photo.on.rectangle.angled"
        case .cardStandard:
            return "rectangle.stack.badge.plus"
        }
    }
}
