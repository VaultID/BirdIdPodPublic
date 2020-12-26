import XCTest
@testable import BirdId

final class BirdIdTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(BirdId().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
