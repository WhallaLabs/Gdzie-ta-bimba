//
//  SearchResult.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

enum SearchResult {
    case stop(model: StopPoint)
    case street(name: String)
    case line(name: String)
}

extension SearchResult: Hashable {
    var hashValue: Int {
        switch self {
        case .stop(let model):
            return model.id.hashValue
        case .line(let name):
            return "line\(name)".hashValue
        case .street(let name):
            return "street\(name)".hashValue
        }
    }
}

func ==(lhs: SearchResult, rhs: SearchResult) -> Bool {
    switch (lhs, rhs) {
    case (.stop(let lModel), .stop(let rModel)):
        return lModel.id == rModel.id
    case (.street(let lName), .street(let rName)):
        return lName == rName
    case (.line(let lName), .line(let rName)):
        return lName == rName
    default:
        return false
    }
}
