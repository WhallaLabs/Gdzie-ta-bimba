//
//  SearchQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON
import RxSwift

final class SearchQueryHandler: QueryHandler {
    
    fileprivate let apiProvider: RestApiProvider
    fileprivate let bodyBuilder: RequestBodyBuilder
    
    init(apiProvider: RestApiProvider) {
        self.apiProvider = apiProvider
        self.bodyBuilder = RequestBodyBuilder()
    }
    
    func handle(_ query: Query) -> Any {
        let query = query as! SearchQuery
        
        let stopPointsObservable = self.observableForMethod(ApiConfig.getStopPoints, query: query, mapper: StopPointMapper()).map(StopPointsToSearchResultsConverter())
        let linesObservable = self.observableForMethod(ApiConfig.getLines, query: query, mapper: LineMapper()).map(LinesToSearchResultsConverter())
        let streetsObservable = self.observableForMethod(ApiConfig.getStreets, query: query, mapper: StreetMapper()).map(StreetsToSearchResultsConverter())
        
        let searchResultObservable = Observable.combineLatest(stopPointsObservable, linesObservable, streetsObservable) { stopPoints, lines, streets -> [SearchResult] in
            var result = stopPoints
            result.append(lines)
            result.append(streets)
            return result
        }
        
        return searchResultObservable
    }
    
    func observableForMethod<T: ObjectMappable>(_ method: SearchMethod, query: SearchQuery, mapper: T) -> Observable<[T.T]> {
        let responseMapper = WrappedObjectMapper(ArrayMapper(mapper), pathToObject: "success")
        let parameters = self.bodyBuilder.search(method, pattern: query.phrase)
        let observable = self.apiProvider.post(parameters, mapper: responseMapper)
        return observable
    }
}
