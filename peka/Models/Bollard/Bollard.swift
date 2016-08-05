//
//  Bollard.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

struct Bollard {
    let mainBollard: Bool
    let name: String
    let symbol: String
    let tag: String
    var isFavorite: Bool
}

extension Bollard: Hashable {
    var hashValue: Int {
        return self.symbol.hashValue
    }
}

func ==(lhs: Bollard, rhs: Bollard) -> Bool {
    return lhs.symbol == rhs.symbol || lhs.symbol == rhs.tag
}