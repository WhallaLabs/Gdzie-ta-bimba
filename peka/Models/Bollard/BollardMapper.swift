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
    
    private let stopPointNameConverter = StopPointNameRemoveNumberConverter()
    
    func mapToObject(json: JSON) -> Bollard? {
        guard let mainBollard = json["mainBollard"].bool,
            name = json["name"].string,
            tag = json["tag"].string,
            symbol = json["symbol"].string else {
                return nil
        }
        let convertedName = stopPointNameConverter.convert(name)
        return Bollard(mainBollard: mainBollard, name: convertedName, symbol: symbol, tag: tag, isFavorite: false)
    }
}