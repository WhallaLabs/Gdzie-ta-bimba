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
    
    fileprivate let stopPointNameConverter = StopPointNameRemoveNumberConverter()
    
    func mapToObject(_ json: JSON) -> Bollard? {
        guard let mainBollard = json["mainBollard"].bool,
            let name = json["name"].string,
            let tag = json["tag"].string,
            let symbol = json["symbol"].string else {
                return nil
        }
        let convertedName = stopPointNameConverter.convert(name)
        return Bollard(mainBollard: mainBollard, name: convertedName, symbol: symbol, tag: tag, isFavorite: false)
    }
}
