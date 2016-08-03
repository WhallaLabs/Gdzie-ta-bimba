//
//  StopPointPushpin.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

struct StopPointPushpin {
    let id: String
    let name: String
    let coordinates: Coordinates
    let headsigns: String
}

extension StopPointPushpin: Equatable {
    
}

func ==(lhs: StopPointPushpin, rhs: StopPointPushpin) -> Bool {
    return lhs.id == rhs.id
}