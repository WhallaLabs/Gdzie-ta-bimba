//
//  BollardsViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class BollardsViewModel {
    fileprivate let executor: Executor
    let bollards = Variable<[GroupedDirections]>([])
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadBollardsByStopPoint(_ stopPoint: StopPoint) -> Disposable {
        let observable: Observable<[GroupedDirections]> = self.executor.execute(GetBollardsByStopPointQuery(stopPoint: stopPoint))
        
        return observable.bindTo(self.bollards)
    }
    
    func loadBollardsByStreet(_ street: String) -> Disposable {
        let observable: Observable<[GroupedDirections]> = self.executor.execute(GetBollardsByStreetQuery(street: street))
        
        return observable.bindTo(self.bollards)
    }
    
    func toggleFavorite(_ bollard: Bollard) {
        self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
    }
}
