//
//  SearchResultRealm.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RealmSwift

enum SearchResultType: Int {
    case stopPoint
    case line
    case street
}

final class SearchResultRealm: Object {
    fileprivate dynamic var typeRaw: Int = SearchResultType.stopPoint.rawValue
    dynamic var id: String? = nil
    dynamic var name: String = ""
    
    var type: SearchResultType {
        get {
            return SearchResultType(rawValue: self.typeRaw)!
        }
        set {
            self.typeRaw = newValue.rawValue
        }
    }
}
