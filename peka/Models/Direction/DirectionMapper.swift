//
//  DirectionMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class DirectionMapper: ObjectMappable {
    
    func mapToObject(_ json: JSON) -> Direction? {
        guard let direction = json["direction"].string,
            let lineName = json["lineName"].string,
            let returnVariant = json["returnVariant"].bool else {
                return nil
        }
        return Direction(directionName: direction, line: lineName, returnVariant: returnVariant)
    }
}
