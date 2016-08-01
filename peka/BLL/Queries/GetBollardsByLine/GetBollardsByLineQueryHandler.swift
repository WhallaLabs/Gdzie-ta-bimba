//
//  GetBollardsByLineQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByLineQueryHandler: QueryHandler {
    
    private let apiProvider: RestApiProvider
    private let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(query: Query) -> Any {
        let query = query as! GetBollardsByLineQuery
        let params = self.bodyBuilder.getBollardsByLine(query.line)
        let mapper = WrappedObjectMapper(ArrayMapper(LineBollardsMapper()), pathToObject: "success", "bollards")
        let observable = self.apiProvider.post(params, mapper: mapper)
        return observable
    }
}