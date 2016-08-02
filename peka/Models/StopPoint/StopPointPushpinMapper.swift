//
//  StopPointPushpinMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class StopPointPushpinMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> StopPointPushpin? {
        guard let id = json["id"].string,
            name = json["properties"]["stop_name"].string,
            headsigns = json["properties"]["headsigns"].string else {
                return nil
        }
        let mapper = CoordinatesMapper()
        let coordinatesJson = json["geometry"]
        guard let coordinates = mapper.mapToObject(coordinatesJson) else {
            return nil
        }
        return StopPointPushpin(id: id, name: name, coordinates: coordinates, headsigns: headsigns)
    }
}