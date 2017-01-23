//
//  TodayViewModel.swift
//  peka
//
//  Created by Wojciech Świerczyk on 20.01.2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class TodayViewModel {
    fileprivate let executor: Executor
    
    let nearestStopPoint = Variable<[StopPointPushpin]>([])
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func initializeNearestStopPoints(_ locationObservable: Observable<Coordinates>) -> Disposable {
        return locationObservable.throttle(1, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] coordinates in self.nearestStop(coordinates) }
            .distinctUntilChanged()
            .bindTo(self.nearestStopPoint)
    }
    
    fileprivate func nearestStop(_ coordinates: Coordinates) -> Observable<[StopPointPushpin]> {
        let observable: Observable<[StopPointPushpin]> = self.executor.execute(GetNearestStopQuery(coordinates: coordinates))
        return observable
    }
}
