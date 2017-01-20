//
//  SearchResultRealmMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class SearchResultRealmToSearchResultMapper: Convertible {
    func convert(_ value: SearchResultRealm) -> SearchResult {
        switch value.type {
        case .line:
            return .line(name: value.name)
        case .stopPoint:
            let stopPoint = StopPoint(id: value.id!, name: value.name)
            return .stop(model: stopPoint)
        case .street:
            return .street(name: value.name)
        }
    }
}

final class SearchResultsRealmToSearchResultsMapper: Convertible {
    func convert(_ value: [SearchResultRealm]) -> [SearchResult] {
        let mapper = SearchResultRealmToSearchResultMapper()
        return value.map(mapper)
    }
}

final class SearchResultToSearchResultRealmMapper: Convertible {
    func convert(_ value: SearchResult) -> SearchResultRealm {
        switch value {
        case .line(let name):
            let line = SearchResultRealm()
            line.name = name
            line.type = .line
            return line
        case .stop(let model):
            let stopPoint = SearchResultRealm()
            stopPoint.id = model.id
            stopPoint.name = model.name
            stopPoint.type = .stopPoint
            return stopPoint
        case .street(let name):
            let street = SearchResultRealm()
            street.name = name
            street.type = .street
            return street
        }
    }
}
