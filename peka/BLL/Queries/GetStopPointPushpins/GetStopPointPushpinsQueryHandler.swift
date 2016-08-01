//
//  GetStopPointPushpinsQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import RxSwift

final class GetStopPointPushpinsQueryHandler: QueryHandler {
    private let apiProvider: RestApiProvider
    private let stopPointsCache: StopPointPushpinsCache
    
    init(apiProvider: RestApiProvider, stopPointsCache: StopPointPushpinsCache) {
        self.apiProvider = apiProvider
        self.stopPointsCache = stopPointsCache
    }
    
    func handle(query: Query) -> Any {
        let mapper = WrappedObjectMapper(ArrayMapper(StopPointPushpinMapper()), pathToObject: "features")
        let cache = self.stopPointsCache
        let observable = self.apiProvider.get(ApiConfig.pushpins, mapper: mapper).flatMap { stopPoints in cache.save(stopPoints) }
        return Observable.of(cache.cached(), observable).concat().take(1)
    }
}