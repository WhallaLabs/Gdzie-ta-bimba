//
//  SaveOrderCommandHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 20/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation

final class SaveOrderCommandHandler: CommandHandler {
    private let favoriteBollardsRepository: FavoriteBollardsRepository
    
    init(favoriteBollardsRepository: FavoriteBollardsRepository) {
        self.favoriteBollardsRepository = favoriteBollardsRepository
    }
    
    func handle(_ command: Command) -> Any {
        let command = command as! SaveOrderCommand
        
        let orderedBollards = command.bollards.enumerated().map { (index, bollard) -> Bollard in
            var bollard = bollard
            bollard.order = index
            return bollard
        }
        
        self.favoriteBollardsRepository.updateMany(bollards: orderedBollards)
        
        return ()
    }
}
