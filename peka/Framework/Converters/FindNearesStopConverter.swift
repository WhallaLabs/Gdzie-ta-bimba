//
//  FindNearesStopConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class FindNearestStopConverter: Convertible {
    
    let coordinates: Coordinates
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    func convert(_ value: [StopPointPushpin]) -> [StopPointPushpin] {
        let nearest = value.sorted { (lStopPoint, rStopPoint) -> Bool in
            let lDistance = self.distanceFromCoordinate(lStopPoint.coordinates, toCoordinates: self.coordinates)
            let rDistance = self.distanceFromCoordinate(rStopPoint.coordinates, toCoordinates: self.coordinates)
            return lDistance < rDistance
            }
        let first = nearest.first!
        return nearest.filter { $0.name == first.name }
    }
    
    fileprivate func distanceFromCoordinate(_ fromCoordinate: Coordinates, toCoordinates: Coordinates) -> Double {
        let latitudeDelta = fromCoordinate.latitude - toCoordinates.latitude
        let longitudeDelta = fromCoordinate.longitude - toCoordinates.longitude
        return sqrt(pow(latitudeDelta, 2) + pow(longitudeDelta, 2))
    }
}
