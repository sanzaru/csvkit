import XCTest
@testable import CSVKit

final class CSVKitTests: XCTestCase {
    static var allTests = [
        ("parserTest", testCSVStringParser),
        ("encoderTest", testCSVEncoder),
    ]
    
    private static let dummyCSVLines: [String] = [
        "Foo;Bar;Foo2;Bar2",
        "Line2\";\"Line2-1\";\"Line2-2\";\"Line2-3\""
    ]
}


// MARK: - Parser tests
extension CSVKitTests {
    func testCSVStringParser() {
        let parsed = CSVParser.shared.parse(from: CSVKitTests.dummyCSVLines.joined(separator: "\n"))
        
        // Check if empty
        XCTAssertFalse(parsed.isEmpty, "Parsed data is empty")
        
        // Check line count
        XCTAssertTrue(parsed.count == 2, "line count: \(parsed.count)")
    }
}


// MARK: - Encoder tests
extension CSVKitTests {
    func testCSVEncoder() {
        do {
            let input = CSVParser.shared.parse(from: CSVKitTests.dummyCSVLines.joined(separator: "\n"))
            let data = try CSVEncoder.shared.encode(from: input)
            
            XCTAssertFalse(data.isEmpty, "Empty CSV data: \(data)")
        } catch {
            XCTFail("Error encoding data: \(error)")
        }
    }
}
