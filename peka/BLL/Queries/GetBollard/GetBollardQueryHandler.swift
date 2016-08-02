//
//  GetBollardQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import RxSwift

final class GetBollardQueryHandler: QueryHandler {
    
    private let apiProvider: RestApiProvider
    private let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(query: Query) -> Any {
        let query = query as! GetBollardQuery
        let parameters = self.bodyBuilder.getTimes(query.symbol)
        let mapper = WrappedObjectMapper(BollardMapper(), pathToObject: "success", "bollard")
        let observable = self.apiProvider.post(parameters, mapper: mapper)
        return observable
    }
}