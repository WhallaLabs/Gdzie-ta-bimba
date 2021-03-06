//
//  GetBollardsByLineQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByLineQueryHandler: QueryHandler {
    
    fileprivate let apiProvider: RestApiProvider
    fileprivate let favoriteLineBollardsComparator: FavoriteLineBollardComparator
    fileprivate let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider, favoriteLineBollardsComparator: FavoriteLineBollardComparator) {
        self.apiProvider = apiProvider
        self.favoriteLineBollardsComparator = favoriteLineBollardsComparator
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetBollardsByLineQuery
        let params = self.bodyBuilder.getBollardsByLine(query.line)
        let mapper = WrappedObjectMapper(ArrayMapper(LineBollardsMapper()), pathToObject: "success", "directions")
        let observable = self.apiProvider.post(params, mapper: mapper)
        return self.favoriteLineBollardsComparator.checkFavorite(observable)
    }
}
