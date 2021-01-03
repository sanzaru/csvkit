import Foundation


fileprivate let CSVKitDefaultSeparator: String = ";"


protocol CSVKitDelegate {
    var separator: String {get set}
}


public enum CSVKitError: Error {
    /// CSV validation error
    case encodingValidation(String)
}


/**
    Simple CSV parser struct
 */
public struct CSVParser: CSVKitDelegate {
    public static let shared: CSVParser = CSVParser()
    public var separator: String
    
    public init() {
        separator = CSVKitDefaultSeparator
    }

    /**
        Parse CSV data from given string

        - Parameters:
            - data: The data to be parsed
            - separator: The CSV separator. Defaults to ;
    */
    public func parse(from data: String) -> [[String]] {
        return data.components(separatedBy: "\n").map {
            $0.components(separatedBy: separator).map {
                // Replace special characters
                $0
                    .replacingOccurrences(of: "\r", with: "")
                    .replacingOccurrences(of: "\n", with: "")
                    .replacingOccurrences(of: "\"", with: "")
            }
        }
    }

    /**
        Parse CSV data from given data object

        - Parameters:
            - data: The data to be parsed
            - separator: The CSV separator. Defaults to: ;
            - encoding: The string encoding. Defaults to: .utf8
    */
    public func parse(from data: Data, with encoding: String.Encoding = .utf8) -> [[String]] {
        guard let stringData = String(data: data, encoding: .utf8) else {
            return [[]]
        }

        return self.parse(from: stringData)
    }
}


/**
    Simple CSV encoder struct
 */
public struct CSVEncoder: CSVKitDelegate {
    public static let shared: CSVEncoder = CSVEncoder()
    public var separator: String
    
    public init() {
        separator = CSVKitDefaultSeparator
    }

    /**
        Encode CSV data from given array of strings
        - Parameters:
            - data: The data to encode
            - encoding: The string encoding. Defaults to: .utf8
        - Throws: `CSVKitError.encodingValidation` with a message of the error
        - Returns: Encoded CSV data
     */
    public func encode(from data: [[String]], with encoding: String.Encoding = .utf8) throws -> String {
        let rows: [String] = try data.map {
            try $0.map {
                // Look for special characters and enclose those strings with quotes,
                // according to: https://tools.ietf.org/html/rfc4180
                let regex = try NSRegularExpression(pattern: "\\W")
                let range = NSRange(location: 0, length: $0.utf8.count)
                return regex.firstMatch(in: $0, options: [], range: range) != nil ? "\"\($0)\"" : $0
            }.joined(separator: separator)
        }

        // Validate row data
        try validate(lines: rows)

        return rows.joined(separator: "\r\n")
    }


    // MARK: - Private methods

    /**
        Validate the lines of CSV data for integrity
        - Parameters:
            - lines: Array with CSV data
        - Throws: `CSVKitError.encodingValidation` with a message of the error
     */
    private func validate(lines: [String]) throws {
        // Check equal item count
        let count = lines.first?.components(separatedBy: separator).count ?? 0

        try lines.forEach { line in
            let currentCount = line.components(separatedBy: separator).count
            if currentCount != count {
                throw CSVKitError.encodingValidation("Invalid item count. Expected \(count), got \(currentCount)")
            }
        }
    }
}
