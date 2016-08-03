//
//  SaveSearchResultCommandHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class SaveSearchResultCommandHandler: CommandHandler {
    
    private let recentSearchRepository: RecentSearchRepository
    
    init(recentSearchRepository: RecentSearchRepository) {
        self.recentSearchRepository = recentSearchRepository
    }
    
    func handle(command: Command) -> Any {
        let command = command as! SaveSearchResultCommand
        self.recentSearchRepository.save(command.searchResult)
        return ()
    }
}