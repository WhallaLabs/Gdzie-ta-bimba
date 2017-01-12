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
    
    fileprivate let apiProvider: RestApiProvider
    fileprivate let favoriteBollardComparator: FavoriteBollardComparator
    fileprivate let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider, favoriteBollardComparator: FavoriteBollardComparator) {
        self.apiProvider = apiProvider
        self.favoriteBollardComparator = favoriteBollardComparator
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetBollardQuery
        let parameters = self.bodyBuilder.getTimes(query.symbol)
        let mapper = WrappedObjectMapper(BollardMapper(), pathToObject: "success", "bollard")
        let observable = self.apiProvider.post(parameters, mapper: mapper)
        return self.favoriteBollardComparator.checkFavorite(observable)
    }
}
