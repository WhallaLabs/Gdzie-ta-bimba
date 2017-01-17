//
//  RemoveAdsCommandHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import StoreKit
import RxSwift

final class RemoveAdsCommandHandler: NSObject, CommandHandler {
    fileprivate var productObservers = [SKProductsRequest: AnyObserver<SKProduct>]()
    fileprivate var paymentObservers = [SKPayment: AnyObserver<Void>]()
    
    func handle(_ command: Command) -> Any {
        return self.removeAdsProduct()
            .flatMap { self.payment(forProduct: $0) }
            .shareReplayLatestWhileConnected()
    }
    
    private func removeAdsProduct() -> Observable<SKProduct> {
        return Observable.create { observer in
            guard SKPaymentQueue.canMakePayments() else {
                observer.onError(NSError())
                return Disposables.create()
            }
            let request = SKProductsRequest(productIdentifiers: [Constants.InApp.removeAds])
            self.productObservers[request] = observer
            request.delegate = self
            request.start()
            
            return Disposables.create {
                request.cancel()
                self.productObservers.removeValue(forKey: request)
            }
        }
    }
    
    private func payment(forProduct product: SKProduct) -> Observable<Void> {
        return Observable.create { observer in
            SKPaymentQueue.default().add(self)
            let payment = SKPayment(product: product)
            self.paymentObservers[payment] = observer
            SKPaymentQueue.default().add(payment)
            return Disposables.create {
                self.paymentObservers.removeValue(forKey: payment)
                SKPaymentQueue.default().remove(self)
            }
        }
    }
}

extension RemoveAdsCommandHandler: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let observer = self.productObservers[request] else {
            return
        }
        guard let product = response.products.first else {
            observer.onError(NSError())
            return
        }
        observer.onNext(product)
        observer.onCompleted()
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        guard let request = request as? SKProductsRequest, let observer = self.productObservers[request] else {
            return
        }
        observer.onError(error)
    }
}

extension RemoveAdsCommandHandler: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        transactions.forEach { transaction in
            guard let observer = self.paymentObservers[transaction.payment] else {
                return
            }
            switch transaction.transactionState {
            case .purchased, .restored:
                observer.onNext()
                observer.onCompleted()
                queue.finishTransaction(transaction)
            case .failed:
                observer.onError(transaction.error!)
                queue.finishTransaction(transaction)
            case .purchasing, .deferred:
                break
            }
        }
    }
}
