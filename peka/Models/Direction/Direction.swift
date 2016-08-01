//
//  Direction.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

struct Direction {
    let name: String
    let line: String
    let returnVariant: Bool
    
    var description: String {
        return "\(self.line) ➙ \(self.name)"
    }
}