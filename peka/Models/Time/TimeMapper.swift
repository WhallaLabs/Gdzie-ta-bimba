//
//  TimeMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class TimeMapper: ObjectMappable {
    
    func mapToObject(_ json: JSON) -> Time? {
        guard let direction = json["direction"].string,
            let line = json["line"].string,
            let minutes = json["minutes"].int,
            let onStopPoint = json["onStopPoint"].bool,
            let realTime = json["realTime"].bool else {
                return nil
        }
        let dateMapper = DateMapper(format: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        guard let departure = dateMapper.mapToObject(json["departure"]) else {
            return nil
        }
        
        let time = Time(departure: departure,
                        directionName: direction,
                        line: line,
                        minutes: minutes,
                        onStopPoint: onStopPoint,
                        realTime: realTime)
        return time
    }
}
