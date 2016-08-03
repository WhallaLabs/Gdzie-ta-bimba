//
//  RealmRecentSearchRepository.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class RealmRecentSearchRepository: RecentSearchRepository {
    private let realm = try! Realm()
    
    func searchHistory() -> Observable<[SearchResult]> {
        return self.realm.objects(SearchResultRealm.self)
            .asObservableArray()
            .map(SearchResultsRealmToSearchResultsMapper())
            .map(DistinctOrdered())
            .shareReplayLatestWhileConnected()
    }
    
    func save(searchResult: SearchResult) {
        let mapper = SearchResultToSearchResultRealmMapper()
        let searchResultRealm = mapper.convert(searchResult)
        try! self.realm.write {
            self.realm.add(searchResultRealm)
        }
    }
}

private final class DistinctOrdered: Convertible {
    func convert(value: [SearchResult]) -> [SearchResult] {
        return value.groupBy { $0 }
            .sortBy { (key, value) in value.count }
            .map { (key, value) in key }
            .take(20)
    }
}