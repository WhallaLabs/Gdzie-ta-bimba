//
//  ToggleBollardFavoriteCommandHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class ToggleBollardFavoriteCommandHandler: CommandHandler {
    
    fileprivate let favoriteBollardsRepository: FavoriteBollardsRepository
    
    init(favoriteBollardsRepository: FavoriteBollardsRepository) {
        self.favoriteBollardsRepository = favoriteBollardsRepository
    }
    
    func handle(_ command: Command) -> Any {
        let command = command as! ToggleBollardFavoriteCommand
        let bollard = command.bollard
        if bollard.isFavorite {
            self.favoriteBollardsRepository.remove(bollard)
        } else {
            self.favoriteBollardsRepository.add(bollard)
        }
        return ()
    }
}
