//
//  VariableExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Variable {
    func twoWayBind<O: protocol<ObserverType, ObservableType> where O.E == E>(observer: O) -> Disposable {
        let d1 = self.asObservable().bindTo(observer)
        let d2 = observer.subscribeNext { [weak self] next in
            self?.value = next
        }
        return CompositeDisposable(d1, d2)
    }
}