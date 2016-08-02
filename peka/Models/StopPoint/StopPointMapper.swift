//
//  StopPointMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class StopPointMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> StopPoint? {
        guard let id = json["symbol"].string,
            name = json["name"].string else {
                return nil
        }
        return StopPoint(id: id, name: name)
    }
}