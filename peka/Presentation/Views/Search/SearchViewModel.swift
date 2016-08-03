//
//  SearchViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class SearchViewModel {
    private let executor: Executor
    private let searchResultSubject = PublishSubject<[SearchResult]>()
    let searchPhrase = Variable(String.empty)
    var searchResult: Observable<[SearchResult]> {
        return self.searchResultSubject.asObservable()
    }
    
    let searchHistory = Variable<[SearchResult]>([])
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func initializeSearch() -> Disposable {
        return self.searchPhrase.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] phrase -> Observable<[SearchResult]> in
                if phrase.isEmpty {
                    return Observable.just([])
                }
                return self.executor.execute(SearchQuery(phrase: phrase))
            }.startWith([])
            .catchErrorJustReturn([])
            .bindTo(self.searchResultSubject)
    }
    
    func loadSearchHistory() -> Disposable {
        let observable: Observable<[SearchResult]> = self.executor.execute(GetSearchHistoryQuery())
        return observable.bindTo(self.searchHistory)
    }
    
    func saveSearch(searchResult: SearchResult) {
        self.executor.execute(SaveSearchResultCommand(searchResult: searchResult))
    }
}