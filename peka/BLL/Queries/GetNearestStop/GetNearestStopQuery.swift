//
//  GetNearestStopQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetNearestStopQuery: Query {
    
    let coordinates: Coordinates
    
    init(coordinates: Coordinates) {
        self.coordinates = coordinates
    }
}