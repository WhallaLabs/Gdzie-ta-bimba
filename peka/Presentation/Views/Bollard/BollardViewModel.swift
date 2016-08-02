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
        let query = GetTimesQuery(bollard: bollard)
        let observable: Observable<[Time]> = self.executor.execute(query)
        return observable.retry(10).bindTo(self.times)
    }
}