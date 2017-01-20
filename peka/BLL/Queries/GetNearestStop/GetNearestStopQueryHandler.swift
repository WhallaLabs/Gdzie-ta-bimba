//
//  GetNearestStopQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetNearestStopQueryHandler: QueryHandler {
    
    fileprivate let stopPointsCache: StopPointPushpinsCache
    
    init(stopPointsCache: StopPointPushpinsCache) {
        self.stopPointsCache = stopPointsCache
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetNearestStopQuery
        let cachedObservable = self.stopPointsCache.cached().filter { $0.any() }
        let nearestObservable = cachedObservable.map(FindNearestStopConverter(coordinates: query.coordinates))
        return nearestObservable
    }
}
