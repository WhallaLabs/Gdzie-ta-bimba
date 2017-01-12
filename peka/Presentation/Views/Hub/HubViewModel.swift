//
//  HubViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class HubViewModel {
    fileprivate let executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func prepareStopPoints() -> Disposable {
        let observable: Observable<[StopPointPushpin]> = self.executor.execute(GetStopPointPushpinsQuery())
        return observable.subscribe()
    }
}
