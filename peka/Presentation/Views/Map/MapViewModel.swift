//
//  MapViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class MapViewModel {
    private let executor: Executor
    
    let pushpins = Variable<[StopPointPushpin]>([])
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func loadStopPoints() -> Disposable {
        let observable: Observable<[StopPointPushpin]> = self.executor.execute(GetStopPointPushpinsQuery())
        return observable.bindTo(self.pushpins)
    }
}