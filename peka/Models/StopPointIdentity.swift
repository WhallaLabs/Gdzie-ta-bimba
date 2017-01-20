//
//  StopPointIdentity.swift
//  peka
//
//  Created by Tomasz Pikć on 13/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation

protocol StopPointIdentity {
    var symbol: String { get }
    var name: String { get }
}

extension Bollard: StopPointIdentity {
    
}

extension StopPointPushpin: StopPointIdentity {
    var symbol: String {
        return self.id
    }
}
