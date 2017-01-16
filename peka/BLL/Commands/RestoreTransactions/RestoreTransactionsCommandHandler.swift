//
//  RestoreTransactionsCommandHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import StoreKit

final class RestoreTransactionsCommandHandler: NSObject, CommandHandler {
    fileprivate var observer: AnyObserver<Void>!
    
    func handle(_ command: Command) -> Any {
        let observable: Observable<Void> = Observable.create { observer in
            self.observer = observer
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
            
            return Disposables.create {
                SKPaymentQueue.default().remove(self)
            }
        }
        return observable
    }
}

extension RestoreTransactionsCommandHandler: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        let transaction = transactions.filter { $0.payment.productIdentifier == Constants.removeAdsInAppId }.first
        guard let removeAdsTransaction = transaction else {
            observer.onError(NSError())
            return
        }
        switch removeAdsTransaction.transactionState {
        case .restored:
            observer.onNext()
            observer.onCompleted()
        default:
            observer.onError(NSError())
        }
    }
}
