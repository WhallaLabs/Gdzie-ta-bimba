//
//  GetBollardsByStopPointQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByStopPointQueryHandler: QueryHandler {
    
    fileprivate let apiProvider: RestApiProvider
    fileprivate let favoriteGroupedDirectionsComparator: FavoriteGroupedDirectionsComparator
    fileprivate let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider, favoriteGroupedDirectionsComparator: FavoriteGroupedDirectionsComparator) {
        self.apiProvider = apiProvider
        self.favoriteGroupedDirectionsComparator = favoriteGroupedDirectionsComparator
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! GetBollardsByStopPointQuery
        let params = self.bodyBuilder.getBollardsByStopPoint(query.stopPoint.name)
        let mapper = WrappedObjectMapper(ArrayMapper(GroupedDirectionsMapper()), pathToObject: "success", "bollards")
        let observable = self.apiProvider.post(params, mapper: mapper)
        return self.favoriteGroupedDirectionsComparator.checkFavourite(observable)
    }
}
