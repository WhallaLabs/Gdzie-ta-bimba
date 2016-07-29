//
//  GetStopPointPushpinsQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import RxSwift

final class GetStopPointPushpinsQueryHandler: QueryHandler {
    private let apiProvider: RestApiProvider
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
    }
    
    func handle(query: Query) -> Any {
        let mapper = ArrayMapper(StopPointPushpinMapper())
        let observable = self.apiProvider.get(ApiConfig.pushpins, mapper: mapper)
        return observable
    }
}