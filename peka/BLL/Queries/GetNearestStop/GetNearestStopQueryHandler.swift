//
//  GetNearestStopQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import RxSwift

final class GetNearestStopQueryHandler: QueryHandler {
    
    private let executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetNearestStopQuery
        let observable: Observable<[StopPointPushpin]> = self.executor.execute(GetStopPointPushpinsQuery())
        let nearestObservable = observable.map(FindNearestStopConverter(coordinates: query.coordinates))
        return nearestObservable
    }
}
