//
//  GetSearchHistoryQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetSearchHistoryQueryHandler: QueryHandler {
    
    private let recentSearchRepository: RecentSearchRepository
    
    init(recentSearchRepository: RecentSearchRepository) {
        self.recentSearchRepository = recentSearchRepository
    }
    
    func handle(query: Query) -> Any {
        let observable = self.recentSearchRepository.searchHistory()
        return observable
    }
}