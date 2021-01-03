//
//  CSVParser.swift
//  
//
//  Created by Martin Albrecht on 03.01.21.
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import Foundation

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
