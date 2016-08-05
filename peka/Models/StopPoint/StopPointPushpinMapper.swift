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
        let propertiesJson = json["properties"]
        guard let id = json["id"].string,
            name = propertiesJson["stop_name"].string,
            headsigns = propertiesJson["headsigns"].string,
            routeTypeRawValueString = propertiesJson["route_type"].string,
            routeTypeRawValue = Int(routeTypeRawValueString),
            zone = propertiesJson["zone"].string else {
                return nil
        }
        let mapper = CoordinatesMapper()
        let coordinatesJson = json["geometry"]
        guard let coordinates = mapper.mapToObject(coordinatesJson),
            routeType = RouteType(rawValue: routeTypeRawValue) else {
                return nil
        }
        var localId = id
        let index = localId.endIndex.advancedBy(-2)
        localId.removeAtIndex(index)
        
        return StopPointPushpin(id: id,
                                name: name,
                                coordinates: coordinates,
                                headsigns: headsigns,
                                routeTypes: [routeType],
                                zone: zone)
    }
}