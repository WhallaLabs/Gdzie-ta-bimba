//
//  PekaApiProviderExtension.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

extension RestApiProvider {
    func post<T: ObjectMappable>(bodyParameters: [HttpBodyParameter], mapper: T) -> Observable<T.T> {
        return self.post(ApiConfig.method, bodyParameters: bodyParameters, mapper: mapper)
    }
}