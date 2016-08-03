//
//  ToggleBollardFavoriteCommandHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class ToggleBollardFavoriteCommandHandler: CommandHandler {
    
    private let favoriteBollardsRepository: FavoriteBollardsRepository
    
    init(favoriteBollardsRepository: FavoriteBollardsRepository) {
        self.favoriteBollardsRepository = favoriteBollardsRepository
    }
    
    func handle(command: Command) -> Any {
        let command = command as! ToggleBollardFavoriteCommand
        var bollard = command.bollard
        if bollard.isFavorite {
            if self.favoriteBollardsRepository.remove(bollard) == false {
                return bollard
            }
        } else {
            self.favoriteBollardsRepository.add(bollard)
        }
        bollard.isFavorite = !bollard.isFavorite
        return bollard
    }
}