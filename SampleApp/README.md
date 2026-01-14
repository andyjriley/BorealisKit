# BorealisKit Sample App

This sample app demonstrates all the components and UCM patterns available in BorealisKit.

## Setup Instructions

### Option 1: Create New Xcode Project (Recommended)

1. Open Xcode
2. Create a new iOS App project (File > New > Project)
3. Choose "App" template
4. Name it "BorealisSampleApp"
5. Set minimum deployment to iOS 15.0
6. Save the project

### Option 2: Use Existing Project Structure

1. Copy the files from `BorealisSampleApp/` folder into your Xcode project
2. Add BorealisKit as a local package dependency

## Adding BorealisKit Dependency

1. In Xcode, select your project in the navigator
2. Select your app target
3. Go to the "Package Dependencies" tab
4. Click the "+" button
5. Click "Add Local..." 
6. Navigate to the parent directory containing `borealis-kit` (the directory with `Package.swift`)
7. Select the `borealis-kit` folder
8. Click "Add Package"

Alternatively, if you want to add it as a file reference:

1. In Xcode, go to File > Add Packages...
2. Click "Add Local..."
3. Navigate to the `borealis-kit` directory (the one containing `Package.swift`)
4. Click "Add Package"

## Project Structure

```
BorealisSampleApp/
├── BorealisSampleAppApp.swift    # App entry point
├── Views/
│   ├── ContentView.swift         # Main view with tabs
│   ├── ComponentsView.swift      # Components showcase
│   ├── ComponentDetailView.swift # Component detail view
│   ├── ComponentType.swift       # Component type enum
│   ├── CardView.swift            # Card component showcase
│   ├── StylesView.swift          # Design system showcase
│   ├── PatternsView.swift        # Patterns list view
│   ├── PatternDetailView.swift   # Pattern detail view
│   ├── PatternType.swift         # Pattern type enum
│   └── PatternContent/           # Pattern content views
│       ├── AlertPatternContent.swift
│       ├── AccordionPatternContent.swift
│       ├── AccordionGroupPatternContent.swift
│       ├── CardConcisePatternContent.swift
│       └── CardStandardPatternContent.swift
├── Assets.xcassets/               # App assets
└── Preview Content/               # Preview assets
```

## Running the App

1. Select a simulator or device
2. Press Cmd+R to build and run
3. Navigate through the tabs to see different components and patterns:
   - **Components**: Individual component showcase with all variants and sizes
   - **Card**: Interactive card component with configuration options
   - **Styles**: Design system showcase (colors, typography, spacing, radius, shadows)
   - **Patterns**: UCM pattern demonstrations

## Features Demonstrated

### Components Tab
- All button variants (primary, secondary, outline, text) and sizes (small, medium, large)
- Input fields with validation
- Alert messages with different types

### Card Tab
- Interactive card component with live configuration
- Image style options (cover, contain)
- CTA type options (primary, secondary, nav, hyperlink)
- Border and new window options

### Styles Tab
- Color palette with hex codes (primary, secondary, semantic, neutral colors)
- Typography scale and text styles
- Spacing system values
- Corner radius values
- Shadow definitions

### Patterns Tab
- **Alert**: Different alert types with action links and custom content
- **Accordion**: Expandable sections with various configurations (size, chevron, alignment, emphasis, variants)
- **Accordion Group**: Multiple accordions with single or multiple expansion modes
- **Card Concise**: Concise cards with image, text overlay, and hover effects
- **Card Standard**: Standard cards with multiple layouts and configurations
