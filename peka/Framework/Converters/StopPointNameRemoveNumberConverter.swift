//
//  StopPointNameRemoveNumberConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class StopPointNameRemoveNumberConverter: Convertible {
    private let regexPattern = " - \\d+$"
    private lazy var regex: NSRegularExpression = {
        return try! NSRegularExpression(pattern: self.regexPattern, options: .CaseInsensitive)
    }()
    
    func convert(value: String) -> String {
        let range = NSMakeRange(0, value.characters.count)
        let name = self.regex.stringByReplacingMatchesInString(value, options: .ReportProgress, range: range, withTemplate: String.empty)
        return name
    }
}