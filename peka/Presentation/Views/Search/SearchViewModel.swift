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
    let activityIndicator = ActivityIndicator()
    
    let searchPhrase = Variable(String.empty)
    var searchResult: Observable<[SearchResult]> {
        return self.searchResultSubject.asObservable()
    }
    
    let searchHistory = Variable<[SearchResult]>([])
    
    var noResults: Observable<Bool> {
        let sampler = self.activityIndicator.asObservable()
            .skip(1)
            .filter { $0 == false }
        
        let noResults = self.searchResult.map { $0.isEmpty }
        let isNotEmpty = self.searchPhrase.asObservable()
            .map { $0.isNotEmpty }
        
        return Observable.combineLatest(noResults.sample(sampler), isNotEmpty) { $0.0 && $0.1 }
            .distinctUntilChanged()
    }
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    func initializeSearch() -> Disposable {
        return self.searchPhrase.asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] phrase -> Observable<[SearchResult]> in
                if phrase.isEmpty {
                    return Observable.just([])
                }
                let observable: Observable<[SearchResult]> = self.executor.execute(SearchQuery(phrase: phrase))
                return observable.trackActivity(self.activityIndicator)
            }.startWith([])
            .catchErrorJustReturn([])
            .bindTo(self.searchResultSubject)
    }
    
    func loadSearchHistory() -> Disposable {
        let observable: Observable<[SearchResult]> = self.executor.execute(GetSearchHistoryQuery())
        return observable.bindTo(self.searchHistory)
    }
    
    func saveSearch(_ searchResult: SearchResult) {
        self.executor.execute(SaveSearchResultCommand(searchResult: searchResult))
    }
}
