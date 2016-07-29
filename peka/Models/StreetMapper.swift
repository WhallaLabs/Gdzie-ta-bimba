//
//  StreetMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class StreetMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> String? {
        return json["name"].string
    }
}