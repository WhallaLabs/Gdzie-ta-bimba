//
//  GetBollardMessageQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import RxSwift

final class GetBollardMessageQueryHandler: QueryHandler {
    
    fileprivate let apiProvider: RestApiProvider
    fileprivate let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetBollardMessageQuery
        let parameters = self.bodyBuilder.bollardMessage(query.symbol)
        
        let mapper = MessageMapper()
        let apiProvider = self.apiProvider
        let observable = Observable<Int>.timer(0, period: 50, scheduler: MainScheduler.instance)
            .flatMap { _ in apiProvider.post(parameters, mapper: mapper) }
        return observable.distinctUntilChanged()
    }
}
