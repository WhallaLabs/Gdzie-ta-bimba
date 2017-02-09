//
//  BollardRealm.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RealmSwift

final class BollardRealm: Object {
    dynamic var mainBollard: Bool = false
    dynamic var name: String = ""
    dynamic var symbol: String = ""
    dynamic var tag: String = ""
    dynamic var order: Int = 0
    
    override static func primaryKey() -> String? {
        return "symbol"
    }
}

extension BollardRealm: Comparable {
    
}

func ==(lhs: BollardRealm, rhs: BollardRealm) -> Bool {
    return lhs.symbol == rhs.symbol
}

func <(lhs: BollardRealm, rhs: BollardRealm) -> Bool {
    return lhs.order < rhs.order
}

func <=(lhs: BollardRealm, rhs: BollardRealm) -> Bool {
    return lhs.order <= rhs.order
}

func >=(lhs: BollardRealm, rhs: BollardRealm) -> Bool {
    return lhs.order >= rhs.order
}

func >(lhs: BollardRealm, rhs: BollardRealm) -> Bool {
    return lhs.order > rhs.order
}
