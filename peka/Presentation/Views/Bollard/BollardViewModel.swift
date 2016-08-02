//
//  BollardViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class BollardViewModel {
    private let executor: Executor
    let times = Variable<[Time]>([])
    let bollard = Variable<Bollard?>(nil)
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadTimesForBollard(bollard: Bollard) -> Disposable {
        self.bollard.value = bollard
        return self.loadTimesForBollard(bollard.symbol)
    }
    
    func loadBollard(symbol: String) -> Disposable {
        let observable: Observable<Bollard> = self.executor.execute(GetBollardQuery(symbol: symbol))
        let bollardDisposable = observable.retry(2).map { $0 as Bollard? }.bindTo(self.bollard)
        let timesDisposable = self.loadTimesForBollard(symbol)
        return CompositeDisposable(bollardDisposable, timesDisposable)
    }
    
    private func loadTimesForBollard(symbol: String) -> Disposable  {
        let query = GetTimesQuery(bollard: symbol)
        let observable: Observable<[Time]> = self.executor.execute(query)
        return observable.retry(10).bindTo(self.times)
    }
    
    func toggleFavorite() {
        guard let bollard = self.bollard.value else {
            return
        }
        let updatedBollard: Bollard = self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
        self.bollard.value = updatedBollard
    }
}