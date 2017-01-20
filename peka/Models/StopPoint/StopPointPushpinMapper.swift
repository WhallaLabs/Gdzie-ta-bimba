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
    
    func mapToObject(_ json: JSON) -> StopPointPushpin? {
        let propertiesJson = json["properties"]
        guard let id = json["id"].string,
            let name = propertiesJson["stop_name"].string,
            let headsigns = propertiesJson["headsigns"].string,
            let routeTypeRawValueString = propertiesJson["route_type"].string,
            let routeTypeRawValue = Int(routeTypeRawValueString),
            let zone = propertiesJson["zone"].string else {
                return nil
        }
        let mapper = CoordinatesMapper()
        let coordinatesJson = json["geometry"]
        guard let coordinates = mapper.mapToObject(coordinatesJson),
            let routeType = RouteType(rawValue: routeTypeRawValue) else {
                return nil
        }
        
        return StopPointPushpin(id: id,
                                name: name,
                                coordinates: coordinates,
                                headsigns: headsigns,
                                routeTypes: [routeType],
                                zone: zone)
    }
}
