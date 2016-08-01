//
//  GetStopPointPushpinsQueryHandlerTests.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
@testable import peka

final class GetStopPointPushpinsQueryHandlerTests: XCTestCase {
    private let cache = StopPointPushpinsCache()
    private let apiProvider = ApiProvider(endpoint: ApiConfig.stopPointsEndpoint, httpHeadersProvider: PekaHttpHeadersProvider(), formBodyBuilder: FormUrlEncodedBuilder())
    private let disposables = DisposeBag()
    
    func testShouldReturnPushpins() {
        let observable = self.createObservable()
        
        let expectation = expectationWithDescription("GetStopPointPushpinsQuery")
        
        observable.subscribeNext { pushpins in
            XCTAssert(pushpins.any())
            expectation.fulfill()
        }.addDisposableTo(self.disposables)
        
        self.waitForExpectationsWithTimeout(5, handler: nil)
        
    }
    
    func testOnSecondUsageShouldReturnCachedPushpins() {
        let localCache = StopPointPushpinsCache()
        let localSelf = self
        
        let observable = self.createObservable(localCache)
        
        let expectation = expectationWithDescription("GetStopPointPushpinsQuery")
        
        observable.take(1).subscribeCompleted {
            let getCachedObservable = localSelf.createObservable(localCache).take(1)
            getCachedObservable.subscribeNext { (pushpins) in
                XCTAssert(pushpins.any())
                expectation.fulfill()
            }.addDisposableTo(localSelf.disposables)
        }.addDisposableTo(self.disposables)
        
        self.waitForExpectationsWithTimeout(5, handler: nil)
        
    }
    
    private func createObservable(cache: StopPointPushpinsCache? = nil) -> Observable<[StopPointPushpin]> {
        let sut = GetStopPointPushpinsQueryHandler(apiProvider: self.apiProvider, stopPointsCache: cache ?? self.cache)
        let observable = sut.handle(GetStopPointPushpinsQuery()) as! Observable<[StopPointPushpin]>
        return observable
    }
}