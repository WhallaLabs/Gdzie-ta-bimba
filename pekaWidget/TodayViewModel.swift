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
    private let disposables = DisposeBag()
    fileprivate let executor: Executor
    let nearestStopPoint = Variable<[StopPointPushpin]>([])
    let times = Variable<[Time]>([])
   
    init(executor: Executor) {
        self.executor = executor
    }
    
    func initializeNearestStopPoints(_ locationObservable: Observable<Coordinates>) -> Disposable {
        return locationObservable.throttle(5, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] coordinates in self.nearestStop(coordinates) }
            .distinctUntilChanged()
            .bindTo(self.nearestStopPoint)
    }
    
    func loadTimesAndMessage(_ symbol: String) -> Observable<Void> {
        let timesQuery = GetTimesQuery(bollard: symbol)
        let timesObservable: Observable<[Time]> = self.executor.execute(timesQuery)
        timesObservable.retry(10).bindTo(self.times).addDisposableTo(self.disposables)
        return timesObservable.map { _ in return Void() }
    }
    
    fileprivate func nearestStop(_ coordinates: Coordinates) -> Observable<[StopPointPushpin]> {
        let observable: Observable<[StopPointPushpin]> = self.executor.execute(GetNearestStopQuery(coordinates: coordinates))
        return observable
    }
}
