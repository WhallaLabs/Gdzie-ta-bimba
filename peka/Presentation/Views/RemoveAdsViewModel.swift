//
//  RemoveAdsViewModel.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class RemoveAdsViewModel {
    let executor: Executor
    let adsSettings: AdsSettings
    
    init(executor: Executor, adsSettings: AdsSettings) {
        self.executor = executor
        self.adsSettings = adsSettings
    }
    
    func removeAds() {
        self.adsSettings.adsDisabled = true
    }
    
    func restoreTransactions() {
        
    }
    
    func restoreAds() {
        self.adsSettings.adsDisabled = false
    }
}
