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
    fileprivate let executor: Executor
    let times = Variable<[Time]>([])
    let bollard = Variable<Bollard?>(nil)
    let message = Variable<NSAttributedString?>(nil)
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadTimesForBollard(_ bollard: Bollard) -> Disposable {
        self.bollard.value = bollard
        return self.loadBollard(bollard.symbol)
    }
    
    func loadBollard(_ symbol: String) -> Disposable {
        let observable: Observable<Bollard> = self.executor.execute(GetBollardQuery(symbol: symbol))
        let bollardDisposable = observable.retry(2).map { $0 as Bollard? }.bindTo(self.bollard)
        let timesDisposable = self.loadTimesAndMessage(symbol)
        return CompositeDisposable(bollardDisposable, timesDisposable)
    }
    
    fileprivate func loadTimesAndMessage(_ symbol: String) -> Disposable  {
        let timesQuery = GetTimesQuery(bollard: symbol)
        let timesObservable: Observable<[Time]> = self.executor.execute(timesQuery)
        let timesDisposable = timesObservable.retry(10).bindTo(self.times)
        
        let messageQuery = GetBollardMessageQuery(symbol: symbol)
        let messageObservable: Observable<NSAttributedString> = self.executor.execute(messageQuery)
        
        let messageDisposable = messageObservable.map(ToOptionalConverter())
            .bindTo(self.message)
        return CompositeDisposable(timesDisposable, messageDisposable)
    }
    
    func toggleFavorite() {
        guard let bollard = self.bollard.value else {
            return
        }
        self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
    }
}
