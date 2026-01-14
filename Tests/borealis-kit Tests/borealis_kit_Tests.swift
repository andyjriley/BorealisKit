import XCTest
@testable import BorealisKit

final class BorealisKitTests: XCTestCase {
    
    func testDesignSystemColors() {
        // Test that colors are accessible
        let primary = BorealisColors.primary
        XCTAssertNotNil(primary)
    }
    
    func testDesignSystemTypography() {
        // Test typography functions
        let heading = BorealisTypography.headingL()
        XCTAssertNotNil(heading)
    }
    
    func testDesignSystemSpacing() {
        // Test spacing values
        XCTAssertEqual(BorealisSpacing.xs, 4)
        XCTAssertEqual(BorealisSpacing.sm, 8)
        XCTAssertEqual(BorealisSpacing.md, 16)
    }
}
