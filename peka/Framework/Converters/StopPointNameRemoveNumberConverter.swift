//
//  StopPointNameRemoveNumberConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class StopPointNameRemoveNumberConverter: Convertible {
    fileprivate let regexPattern = " - \\d+$"
    fileprivate lazy var regex: NSRegularExpression = {
        return try! NSRegularExpression(pattern: self.regexPattern, options: .caseInsensitive)
    }()
    
    func convert(_ value: String) -> String {
        let range = NSMakeRange(0, value.characters.count)
        let name = self.regex.stringByReplacingMatches(in: value, options: .reportProgress, range: range, withTemplate: String.empty)
        return name
    }
}
