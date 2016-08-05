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
    
    private let apiProvider: RestApiProvider
    private let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(query: Query) -> Any {
        let query = query as! GetBollardMessageQuery
        let parameters = self.bodyBuilder.bollardMessage(query.symbol)
        //TODO: message mapper
        let mapper = RawJsonMapper()
        let apiProvider = self.apiProvider
        return Observable<Int>.timer(0, period: 50, scheduler: MainScheduler.instance)
            .flatMap { _ in apiProvider.post(parameters, mapper: mapper) }
    }
}