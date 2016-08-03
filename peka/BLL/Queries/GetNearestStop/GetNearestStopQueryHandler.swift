//
//  GetNearestStopQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetNearestStopQueryHandler: QueryHandler {
    
    private let stopPointsCache: StopPointPushpinsCache
    
    init(stopPointsCache: StopPointPushpinsCache) {
        self.stopPointsCache = stopPointsCache
    }
    
    func handle(query: Query) -> Any {
        let query = query as! GetNearestStopQuery
        let cachedObservable = self.stopPointsCache.cached().filter { $0.any() }
        let nearestObservable = cachedObservable.map(FindNearesStopConverter(coordinates: query.coordinates))
        return nearestObservable
    }
}

private final class FindNearesStopConverter: Convertible {
    
    let coordinates: Coordinates
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
    
    func convert(value: [StopPointPushpin]) -> StopPointPushpin {
        return value.sort { (lStopPoint, rStopPoint) -> Bool in
            let lDistance = self.distanceFromCoordinate(lStopPoint.coordinates, toCoordinates: self.coordinates)
            let rDistance = self.distanceFromCoordinate(rStopPoint.coordinates, toCoordinates: self.coordinates)
            return lDistance < rDistance
        }.first!
    }
    
    private func distanceFromCoordinate(fromCoordinate: Coordinates, toCoordinates: Coordinates) -> Double {
        let latitudeDelta = fromCoordinate.latitude - toCoordinates.latitude
        let longitudeDelta = fromCoordinate.longitude - toCoordinates.longitude
        return sqrt(pow(latitudeDelta, 2) + pow(longitudeDelta, 2))
    }
}