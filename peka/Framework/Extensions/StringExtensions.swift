//
//  StringExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
    }
    
    mutating func appendPathComponent(path: String) {
        let path = path.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "/"))
        if self.hasSuffix("/") {
            self.appendContentsOf(path)
        } else {
            self.appendContentsOf("/" + path)
        }
    }
    
    static var empty: String {
        return ""
    }
}