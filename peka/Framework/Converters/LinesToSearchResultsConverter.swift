//
//  LinesToSearchResultsConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class LinesToSearchResultsConverter: Convertible {
    func convert(value: [String]) -> [SearchResult] {
        return value.map { SearchResult.Line(name: $0) }
    }
}