//
//  BollardMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class BollardMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> Bollard? {
        guard let mainBollard = json["mainBollard"].bool,
            name = json["name"].string,
            symbol = json["symbol"].string,
            tag = json["tag"].string else {
                return nil
        }
        return Bollard(mainBollard: mainBollard, name: name, symbol: symbol, tag: tag)
    }
}