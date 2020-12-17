import XCTest
@testable import CSVKit

final class CSVKitTests: XCTestCase {
    static var allTests = [
        ("parserTest", testCSVStringParser),
        ("encoderTest", testCSVEncoder),
        ("roundtrip", testRoundtrip),
        ("validation", testValidation),
    ]
    
    private static let dummyCSVLines: String = [
        "Foo;Bar;Foo2;Bar2",
        "Line2;Line2-1;Line2-2;Line2-3"
    ].joined(separator: "\r\n")
    
    private static let corruptedCSVData: [[String]] = [
        ["Foo", "Bar", "Foo2", "Bar2"],
        ["Line2", "Line2-1", "Line2-3"]
    ]
    
    private static let expectEncodedCSVData: String = "Foo;Bar;Foo2;Bar2\r\nLine2;\"Line2-1\";\"Line2-2\";\"Line2-3\""
    private static let expectDecodedCSVData: [[String]] = [
        ["Foo", "Bar", "Foo2", "Bar2"],
        ["Line2", "Line2-1", "Line2-2", "Line2-3"]
    ]
}


// MARK: - Parser tests
extension CSVKitTests {
    func testCSVStringParser() {
        let parsed = CSVParser.shared.parse(from: CSVKitTests.dummyCSVLines)
        
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
            let input = CSVParser.shared.parse(from: CSVKitTests.dummyCSVLines)
            let data = try CSVEncoder.shared.encode(from: input)
            
            XCTAssertFalse(data.isEmpty, "Empty CSV data: \(data)")
        } catch {
            XCTFail("Error encoding data: \(error)")
        }
    }
}


// MARK: - Roundtrip test
extension CSVKitTests {
    func testRoundtrip() {
        do {
            let input = CSVParser.shared.parse(from: CSVKitTests.dummyCSVLines)
            let data = try CSVEncoder.shared.encode(from: input)
            
            XCTAssertFalse(data.isEmpty, "Empty CSV data: \(data)")
            
            XCTAssertEqual(data, CSVKitTests.expectEncodedCSVData)
            
            let decoded = CSVParser.shared.parse(from: data)
            XCTAssertEqual(decoded, CSVKitTests.expectDecodedCSVData)
        } catch {
            XCTFail("Error encoding data: \(error)")
        }
    }
}


// MARK: - Test validation
extension CSVKitTests {
    func testValidation() {
        XCTAssertThrowsError(try CSVEncoder.shared.encode(from: CSVKitTests.corruptedCSVData))        
    }
}
