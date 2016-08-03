//
//  SaveSearchResultCommand.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class SaveSearchResultCommand: Command {
    
    let searchResult: SearchResult
    
    init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
}