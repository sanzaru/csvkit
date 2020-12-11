import XCTest
@testable import CSVKit

final class CSVKitTests: XCTestCase {
    private static let dummyCSVLines: [String] = [
        "Foo;Bar;Foo2;Bar2",
        "Line2\";\"Line2-1\";\"Line2-2\";\"Line2-3\""
    ]
    
    func testCSVStringParser() {
        let parsed = CSVParser.shared.parse(from: CSVKitTests.dummyCSVLines.joined(separator: "\n"))
        
        // Check if empty
        XCTAssertFalse(parsed.isEmpty, "Parsed data is empty")
        
        // Check line count
        XCTAssertTrue(parsed.count == 2, "line count: \(parsed.count)")
    }

    static var allTests = [
        ("parserTest", testCSVStringParser),
    ]
}
