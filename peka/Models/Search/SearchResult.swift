//
//  SearchResult.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

enum SearchResult {
    case Stop(model: StopPoint)
    case Street(name: String)
    case Line(name: String)
}

extension SearchResult: Hashable {
    var hashValue: Int {
        switch self {
        case .Stop(let model):
            return model.id.hashValue
        case .Line(let name):
            return "line\(name)".hashValue
        case .Street(let name):
            return "street\(name)".hashValue
        }
    }
}

func ==(lhs: SearchResult, rhs: SearchResult) -> Bool {
    switch (lhs, rhs) {
    case (.Stop(let lModel), .Stop(let rModel)):
        return lModel.id == rModel.id
    case (.Street(let lName), .Street(let rName)):
        return lName == rName
    case (.Line(let lName), .Line(let rName)):
        return lName == rName
    default:
        return false
    }
}