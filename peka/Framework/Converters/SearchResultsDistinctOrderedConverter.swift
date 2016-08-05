//
//  SearchResultsDistinctOrderedConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class SearchResultsDistinctOrderedConverter: Convertible {
    
    func convert(value: [SearchResult]) -> [SearchResult] {
        return value.categorise { $0 }
            .sortBy { (key, value) in value.count }
            .map { (key, value) in key }
            .take(20)
    }
}