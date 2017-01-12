//
//  LineBollardsViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class LineBollardsViewModel {
    fileprivate let executor: Executor
    let lineBollards = Variable<[LineBollards]>([])
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadBollards(_ line: String) -> Disposable {
        let query = GetBollardsByLineQuery(line: line)
        let observable: Observable<[LineBollards]> = self.executor.execute(query)
        
        return observable.bindTo(self.lineBollards)
    }
    
    func toggleFavorite(_ bollard: Bollard) {
        self.executor.execute(ToggleBollardFavoriteCommand(bollard: bollard))
    }
}
