//
//  BollardRealmMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class BollardRealmToBollardMapper: Convertible {
    
    func convert(value: BollardRealm) -> Bollard {
        return Bollard(mainBollard: value.mainBollard,
                       name: value.name,
                       symbol: value.symbol,
                       tag: value.tag,
                       isFavorite: true,
                       localId: value.localId)
    }
}

final class BollardsRealmToBollardsMapper: Convertible {
    
    func convert(value: [BollardRealm]) -> [Bollard] {
        let mapper = BollardRealmToBollardMapper()
        return value.map(mapper)
    }
}

final class BollardToBollardRealmMapper: Convertible {
    
    func convert(value: Bollard) -> BollardRealm {
        let bollard = BollardRealm()
        bollard.mainBollard = value.mainBollard
        bollard.name = value.name
        bollard.symbol = value.symbol
        bollard.tag = value.tag
        bollard.localId = value.localId
        return bollard
    }
}