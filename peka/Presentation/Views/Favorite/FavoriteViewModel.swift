//
//  FavoriteViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class FavoriteViewModel {
    private let executor: Executor
    
    let bollards = Variable<[Bollard]>([])
    let nearestStopPoint = Variable<StopPointPushpin?>(nil)
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadFavouriteBollards() -> Disposable {
        let observable: Observable<[Bollard]> = self.executor.execute(GetFavoriteBollardsQuery())
        return observable.bindTo(self.bollards)
    }
    
    func initializeNearestStopPoint(locationObservable: Observable<Coordinates>) -> Disposable {
        return locationObservable.throttle(1, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] coordinates in self.nearesStop(coordinates) }
            .distinctUntilChanged()
            .map { $0 as StopPointPushpin? }
            .bindTo(self.nearestStopPoint)
    }
    
    func toggleFavorite(bollard: Bollard) {
        self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
    }
    
    private func nearesStop(coordinates: Coordinates) -> Observable<StopPointPushpin> {
        let observable: Observable<StopPointPushpin> = self.executor.execute(GetNearestStopQuery(coordinates: coordinates))
        return observable
    }
}