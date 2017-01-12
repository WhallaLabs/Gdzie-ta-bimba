//
//  GroupBollardDirectionsConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class GroupBollardDirectionsConverter: Convertible {
    func convert(_ value: [GroupedDirections]) -> [GroupedDirections] {
        return value.categorise { $0 }.map { (key, value) in
            let directions: [Direction] = value.flatMap { $0.directions }.distinct().sortBy { Int($0.line) ?? 0 }.reversed()
            return GroupedDirections(bollard: key.bollard, directions: directions)
        }
    }
}
