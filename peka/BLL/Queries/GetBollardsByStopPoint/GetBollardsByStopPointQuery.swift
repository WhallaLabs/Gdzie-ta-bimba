//
//  GetBollardsByStopPointQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByStopPointQuery: Query {
    let stopPoint: StopPoint
    
    init(stopPoint: StopPoint) {
    	self.stopPoint = stopPoint
    }
}