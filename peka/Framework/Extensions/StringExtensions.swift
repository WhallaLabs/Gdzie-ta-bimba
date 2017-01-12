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
    
    mutating func appendPathComponent(_ path: String) {
        let path = path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        if self.hasSuffix("/") {
            self.append(path)
        } else {
            self.append("/" + path)
        }
    }
    
    static var empty: String {
        return ""
    }
}
