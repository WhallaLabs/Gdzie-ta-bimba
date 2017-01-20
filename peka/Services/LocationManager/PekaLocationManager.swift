//
//  PekaLocationManager.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class PekaLocationManager : LocationManager {
    
    fileprivate let manager = CLLocationManager()
    
    var hasPermission: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    init() {
        self.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func requestPermission() {
        self.manager.requestWhenInUseAuthorization()
    }
    
    func userLocation() -> Observable<Coordinates> {
        let startTrackingObservable = Observable<Void>.create { observer in
            self.manager.startUpdatingLocation()
            observer.onNext()
            
            return Disposables.create {
                self.manager.stopUpdatingLocation()
            }
        }
        
        let locationObservable = self.manager.rx.didUpdateLocations.flatMap { Observable.from($0) }
            .map(CLLocationToCoordinatesConverter())
            .shareReplayLatestWhileConnected()
        
        return startTrackingObservable.flatMap { locationObservable }
    }
}
