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
    func map<T: Convertible where T.TIn == E>(converter: T) -> Observable<T.TOut> {
        return self.map { value -> T.TOut in
            return converter.convert(value)
        }
    }

}
