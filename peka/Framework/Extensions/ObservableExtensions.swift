//
//  ObservableExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {
    func map<T: Convertible>(_ converter: T) -> Observable<T.TOut> where T.TIn == E {
        return self.map { value -> T.TOut in
            return converter.convert(value)
        }
    }
    
    func filter<T: Filtering>(_ filter: T) -> Observable<E> where T.T == E {
        return self.filter { filter.filter($0) }
    }
    
    func subscribeNext(_ onNext: @escaping ((E) -> Void)) -> Disposable {
        return self.subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }

}
