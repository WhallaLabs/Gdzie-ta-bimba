//
//  GetBollardsByStreetQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByStreetQueryHandler: QueryHandler {
    
    private let apiProvider: RestApiProvider
    private let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(query: Query) -> Any {
        let query = query as! GetBollardsByStreetQuery
        let params = self.bodyBuilder.getBollardsByStreet(query.street)
        let mapper = WrappedObjectMapper(ArrayMapper(GroupedDirectionsMapper()), pathToObject: "success", "bollards")
        let observable = self.apiProvider.post(params, mapper: mapper)
        return observable
    }
}