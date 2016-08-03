//
//  GetBollardMessageQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardMessageQuery: Query {
    let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
}