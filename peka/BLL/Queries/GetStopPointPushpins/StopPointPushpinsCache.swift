//
//  StopPointPushpinsCache.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class StopPointPushpinsCache: Caching {
    
    private var cachedStopPoints: [StopPointPushpin]?
    
    func cached() -> Observable<[StopPointPushpin]> {
        guard let stopPoints = self.cachedStopPoints else {
            return Observable.empty()
        }
        return Observable.just(stopPoints)
    }
    
    func save(data: [StopPointPushpin]) -> Observable<[StopPointPushpin]> {
        self.cachedStopPoints = data
        return Observable.just(data)
    }
}