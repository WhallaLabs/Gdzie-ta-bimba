//
//  StopPointType.swift
//  peka
//
//  Created by Tomasz Pikć on 13/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxDataSources

enum StopPointType {
    case nearest(stopPoint: StopPointPushpin)
    case favorite(bollard: Bollard)
}

extension StopPointType: IdentifiableType {
    var hashValue: Int {
        switch  self {
        case .favorite(let bollard):
            return bollard.hashValue ^ 13
        case .nearest(let stopPoint):
            return stopPoint.hashValue ^ -7
        }
    }
    
    var identity: Int {
        return self.hashValue
    }
}

extension StopPointType: Equatable {
    
}

func ==(lhs: StopPointType, rhs: StopPointType) -> Bool {
    switch (lhs, rhs) {
    case (.favorite(let lhsBollard), .favorite(let rhsBollard)):
        return lhsBollard == rhsBollard
    case (.nearest(let lhsStopPoint), .nearest(let rhsStopPoint)):
        return lhsStopPoint == rhsStopPoint
    default:
        return false
    }
}

extension StopPointType: StopPointIdentity {
    var symbol: String {
        switch  self {
        case .favorite(let bollard):
            return bollard.symbol
        case .nearest(let stopPoint):
            return stopPoint.symbol
        }
    }
    
    var name: String {
        switch  self {
        case .favorite(let bollard):
            return bollard.name
        case .nearest(let stopPoint):
            return stopPoint.name
        }
    }
}
