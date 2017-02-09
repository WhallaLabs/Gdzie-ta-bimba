//
//  FavoriteViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

final class FavoriteViewModel {
    fileprivate let executor: Executor
    
    let bollards = Variable<[Bollard]>([])
    let nearestStopPoint = Variable<[StopPointPushpin]>([])
    
    var stopPoints: Observable<[FavoriteSection]> {
        return Observable.combineLatest(self.bollards.asObservable(), self.nearestStopPoint.asObservable()) { favorite, nearestStopPoints in
            let favoriteSection = FavoriteSection(favorite: favorite)
            let nearestSection = FavoriteSection(nearestStopPoints: nearestStopPoints)
            return [nearestSection, favoriteSection]
        }
    }
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadFavouriteBollards() -> Disposable {
        let observable: Observable<[Bollard]> = self.executor.execute(GetFavoriteBollardsQuery())
        return observable.bindTo(self.bollards)
    }
    
    func initializeNearestStopPoints(_ locationObservable: Observable<Coordinates>) -> Disposable {
        return locationObservable.debounce(0.8, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] coordinates in self.nearesStop(coordinates) }
            .distinctUntilChanged()
            .bindTo(self.nearestStopPoint)
    }
    
    func toggleFavorite(_ bollard: Bollard) {
        self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
    }
    
    func saveOrder(sections: [FavoriteSection]) {
        let favorite = sections.filter { $0.identity == .favorite }
            .first
        guard let items = favorite?.items else {
            return
        }
        let bollards = items.map(StopPointTypeToBollardConverter()).flatMap { $0 }
        self.executor.execute(SaveOrderCommand(bollards: bollards))
    }
    
    fileprivate func nearesStop(_ coordinates: Coordinates) -> Observable<[StopPointPushpin]> {
        let observable: Observable<[StopPointPushpin]> = self.executor.execute(GetNearestStopQuery(coordinates: coordinates))
        return observable
    }
}
