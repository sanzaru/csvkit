//
//  CSVKit.swift
//
//  Copyright © 2020 Martin Albrecht. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import Foundation


public let CSVKitDefaultSeparator: String = ";"


protocol CSVKitDelegate {
    var separator: String {get set}
}



public enum CSVKitError: Error {
    /// CSV validation error
    case encodingValidation(String)
}
