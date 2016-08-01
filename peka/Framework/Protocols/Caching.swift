//
//  Caching.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

protocol Caching {
    associatedtype T
    
    func cached() -> Observable<T>
    func save(data: T) -> Observable<T>
}