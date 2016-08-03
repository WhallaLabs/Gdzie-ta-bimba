//
//  ApiConfig.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

typealias SearchMethod = String

struct ApiConfig {
    static let stopPointsEndpoint = "http://www.poznan.pl/mim/plan"
    static let pekaEndpoint = "http://www.peka.poznan.pl/vm"
    
    static let pushpins = "map_service.html?mtype=pub_transport&co=cluster"
    static let method = "method.vm"
    
    static let getStopPoints: SearchMethod = "getStopPoints"
    static let getStreets: SearchMethod = "getStreets"
    static let getLines: SearchMethod = "getLines"
    
    static let getBollardsByStopPoint = "getBollardsByStopPoint"
    static let getBollardsByLine = "getBollardsByLine"
    static let getBollardsByStreet = "getBollardsByStreet"
    
    static let getTimes = "getTimes"
    
    static let findMessagesForBollard = "findMessagesForBollard"
}