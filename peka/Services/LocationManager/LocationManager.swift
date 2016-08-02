//
//  LocationManager.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

protocol LocationManager {
    var hasPermission: Bool { get }
    
    func requestPermission()
    func userLocation() -> Observable<Coordinates>
}