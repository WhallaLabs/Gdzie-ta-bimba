//
//  GroupStopPointsConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class GroupStopPointsConverter: Convertible {
    func convert(value: [StopPointPushpin]) -> [StopPointPushpin] {
        return value.categorise { $0 }.map { (key, value) in
            let headsigns = value.map { $0.headsigns }.joinWithSeparator(", ")
            let routeTypes = value.flatMap { $0.routeTypes }.distinct()
            return StopPointPushpin(id: key.id,
                name: key.name,
                coordinates: key.coordinates,
                headsigns: headsigns,
                routeTypes: routeTypes,
                zone: key.zone)
        }
    }
}