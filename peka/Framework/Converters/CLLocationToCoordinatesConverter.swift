//
//  CLLocationToCoordinatesConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import CoreLocation

final class CLLocationToCoordinatesConverter: Convertible {
    func convert(_ value: CLLocation) -> Coordinates {
        return Coordinates(latitude: value.coordinate.latitude, longitude: value.coordinate.longitude)
    }
}
