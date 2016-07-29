//
//  CoordinatesMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class CoordinatesMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> Coordinates? {
        guard let coordinatesArray = json["coordinates"].array where coordinatesArray.count == 2 else {
            return nil
        }
        guard let longitude = coordinatesArray[0].double,
            latitude = coordinatesArray[1].double else {
                return nil
        }
        return Coordinates(latitude: latitude, longitude: longitude)
    }
}