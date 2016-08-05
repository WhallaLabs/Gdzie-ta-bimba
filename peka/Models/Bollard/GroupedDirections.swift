//
//  GroupedDirections.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

struct GroupedDirections {
    let bollard: Bollard
    let directions: [Direction]
}

extension GroupedDirections: Hashable {
    var hashValue: Int {
        return bollard.hashValue
    }
}

func ==(lhs: GroupedDirections, rhs: GroupedDirections) -> Bool {
    return lhs.bollard == rhs.bollard
}