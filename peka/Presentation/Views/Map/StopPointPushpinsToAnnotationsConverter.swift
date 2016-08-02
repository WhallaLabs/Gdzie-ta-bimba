//
//  StopPointPushpinsToAnnotationsConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import CoreLocation

final class StopPointPushpinsToAnnotationsConverter: Convertible {
    func convert(value: [StopPointPushpin]) -> [StopPointAnnotation] {
        return value.map { StopPointAnnotation(id: $0.id, coordinate: CLLocationCoordinate2DMake($0.coordinates.latitude, $0.coordinates.longitude), title: $0.name) }
    }
}