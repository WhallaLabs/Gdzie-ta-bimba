//
//  SearchResultRealmMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class SearchResultRealmToSearchResultMapper: Convertible {
    func convert(value: SearchResultRealm) -> SearchResult {
        switch value.type {
        case .Line:
            return .Line(name: value.name)
        case .StopPoint:
            let stopPoint = StopPoint(id: value.id!, name: value.name)
            return .Stop(model: stopPoint)
        case .Street:
            return .Street(name: value.name)
        }
    }
}

final class SearchResultsRealmToSearchResultsMapper: Convertible {
    func convert(value: [SearchResultRealm]) -> [SearchResult] {
        let mapper = SearchResultRealmToSearchResultMapper()
        return value.map(mapper)
    }
}

final class SearchResultToSearchResultRealmMapper: Convertible {
    func convert(value: SearchResult) -> SearchResultRealm {
        switch value {
        case .Line(let name):
            let line = SearchResultRealm()
            line.name = name
            line.type = .Line
            return line
        case .Stop(let model):
            let stopPoint = SearchResultRealm()
            stopPoint.id = model.id
            stopPoint.name = model.name
            stopPoint.type = .StopPoint
            return stopPoint
        case .Street(let name):
            let street = SearchResultRealm()
            street.name = name
            street.type = .Street
            return street
        }
    }
}