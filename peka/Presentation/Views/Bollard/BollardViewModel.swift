//
//  BollardViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class BollardViewModel {
    private let executor: Executor
    let times = Variable<[Time]>([])
    let bollard = Variable<Bollard?>(nil)
    let message = Variable(String.empty)
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadTimesForBollard(bollard: Bollard) -> Disposable {
        self.bollard.value = bollard
        return self.loadTimesAndMessage(bollard.symbol)
    }
    
    func loadBollard(symbol: String) -> Disposable {
        let observable: Observable<Bollard> = self.executor.execute(GetBollardQuery(symbol: symbol))
        let bollardDisposable = observable.retry(2).map { $0 as Bollard? }.bindTo(self.bollard)
        let timesDisposable = self.loadTimesAndMessage(symbol)
        return CompositeDisposable(bollardDisposable, timesDisposable)
    }
    
    private func loadTimesAndMessage(symbol: String) -> Disposable  {
        let timesQuery = GetTimesQuery(bollard: symbol)
        let timesObservable: Observable<[Time]> = self.executor.execute(timesQuery)
        let timesDisposable = timesObservable.retry(10).bindTo(self.times)
        
        let messageQuery = GetBollardMessageQuery(symbol: symbol)
        let messageObservable: Observable<JSON> = self.executor.execute(messageQuery)
        //TODO
        let messageDisposable = messageObservable.doOnNext { print($0) }
            .filter { $0["success"].array?.count != 0 }
            .map { "\($0)\n\($0.rawString() ?? String.empty)" }
            .bindTo(self.message)
        return CompositeDisposable(timesDisposable, messageDisposable)
    }
    
    func toggleFavorite() {
        guard let bollard = self.bollard.value else {
            return
        }
        let updatedBollard: Bollard = self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
        self.bollard.value = updatedBollard
    }
}