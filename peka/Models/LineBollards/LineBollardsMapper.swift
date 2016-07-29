//
//  LineBollardsMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class LineBollardsMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> LineBollards? {
    	let arrayMapper = ArrayMapper(BollardMapper())
        let directionMapper = DirectionMapper()
        guard let direction = directionMapper.mapToObject(json["direction"]),
            bollards = arrayMapper.mapToObject(json["bollards"]) else {
                return nil
        }
        let lineBollards = LineBollards(direction: direction, bollards: bollards)
        return lineBollards
    }
}