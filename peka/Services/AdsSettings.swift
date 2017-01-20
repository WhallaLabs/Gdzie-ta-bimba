//
//  AdsSettings.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class AdsSettings {
    private let key = "AdsSettings.adsDisabled"
    private let adsDisabledSubject: BehaviorSubject<Bool>
    
    var adsDisabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: self.key)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.key)
            self.adsDisabledSubject.onNext(newValue)
        }
    }
    
    var adsDisabledObservable: Observable<Bool> {
        return self.adsDisabledSubject.asObservable()
    }
    
    init() {
        self.adsDisabledSubject = BehaviorSubject(value: UserDefaults.standard.bool(forKey: self.key))
    }
}
