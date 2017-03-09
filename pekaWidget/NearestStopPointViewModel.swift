//
//  NearestStopPointViewModel.swift
//  peka
//
//  Created by Wojciech Świerczyk on 20.01.2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class NearestStopPointViewModel {
    private let executor: Executor
    let nearestStopPoint = Variable<StopPointPushpin?>(nil)
    let times = Variable<[Time]>([])
   
    init(executor: Executor) {
        self.executor = executor
    }
    
    func initializeNearestStopPoints(_ locationObservable: Observable<Coordinates>) -> Observable<StopPointPushpin?> {
        return locationObservable.throttle(1, scheduler: MainScheduler.instance)
            .flatMapLatest { [unowned self] coordinates -> Observable<[StopPointPushpin]> in
                self.executor.execute(GetNearestStopQuery(coordinates: coordinates))
            }.distinctUntilChanged()
            .map { $0.first }
            .take(1)
    }
    
    func loadTimes(_ symbol: String) -> Observable<Void> {
        let timesQuery = GetTimesQuery(bollard: symbol)
        let timesObservable: Observable<[Time]> = self.executor.execute(timesQuery)
        return timesObservable.retry(3).map { times in
            self.times.value = times
        }
    }
}
