//
//  GetBollardsByLineQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByLineQuery: Query {
    let line: String
    
    init(line: String) {
        self.line = line
    }
}