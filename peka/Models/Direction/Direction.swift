//
//  Direction.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

struct Direction: DirectionDescription {
    let directionName: String
    let line: String
    let returnVariant: Bool
}

extension Direction: Hashable {
    var hashValue: Int {
        return "\(self.line)-\(self.directionName)".hashValue
    }
}

func ==(lhs: Direction, rhs: Direction) -> Bool {
    return lhs.line == rhs.line && lhs.directionName == rhs.directionName
}