import XCTest
@testable import abjc_ui

final class abjc_uiTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(abjc_ui().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
