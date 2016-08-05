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
            tag = json["tag"].string,
            symbol = json["symbol"].string else {
                return nil
        }
        var localId = symbol
        let index = localId.endIndex.advancedBy(-2)
        localId.removeAtIndex(index)
        return Bollard(mainBollard: mainBollard, name: name, symbol: symbol, tag: tag, isFavorite: false, localId: localId)
    }
}