//
//  GetBollardQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardQuery: Query {
    
    let symbol: String
    
    init(symbol: String) {
        self.symbol = symbol
    }
}