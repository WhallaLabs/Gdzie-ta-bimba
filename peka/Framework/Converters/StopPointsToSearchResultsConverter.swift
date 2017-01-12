//
//  StopPointsToSearchResultsConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class StopPointsToSearchResultsConverter: Convertible {
    func convert(_ value: [StopPoint]) -> [SearchResult] {
        return value.map { SearchResult.stop(model: $0) }
    }
}
