//
//  RecentSearchRepository.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

protocol RecentSearchRepository {
    func searchHistory() -> Observable<[SearchResult]>
    func save(searchResult: SearchResult)
}