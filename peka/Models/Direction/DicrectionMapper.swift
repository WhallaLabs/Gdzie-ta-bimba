//
//  DicrectionMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class DicrectionMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> Dicrection? {
        guard let direction = json["direction"].string,
            lineName = json["lineName"].string,
            returnVariant = json["returnVariant"].bool else {
                return nil
        }
        return Dicrection(name: direction, line: lineName, returnVariant: returnVariant)
    }
}