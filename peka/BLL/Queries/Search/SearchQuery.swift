//
//  SearchQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class SearchQuery: Query {
    
    let phrase: String
    
    init(phrase: String) {
        self.phrase = phrase
    }
}