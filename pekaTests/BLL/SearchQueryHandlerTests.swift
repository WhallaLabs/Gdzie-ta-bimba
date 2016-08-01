//
//  SearchQueryHandlerTests.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
@testable import peka

final class SearchQueryHandlerTests: XCTestCase {
    private let disposables = DisposeBag()
    
    func testSearch() {
        let sut = SearchQueryHandler(apiProvider: ApiProvider(endpoint: ApiConfig.pekaEndpoint, httpHeadersProvider: PekaHttpHeadersProvider(), formBodyBuilder: FormUrlEncodedBuilder()))
        let observable = sut.handle(SearchQuery(phrase: "Smol")) as! Observable<[SearchResult]>
        
        let expectation = expectationWithDescription("SearchQuery")
        
        observable.subscribeNext { result in
            XCTAssertTrue(result.any())
            expectation.fulfill()
        }.addDisposableTo(self.disposables)
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
}