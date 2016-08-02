//
//  GetFavoriteBollardsQueryHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetFavoriteBollardsQueryHandler: QueryHandler {
    
    private let favoriteBollardsRepository: FavoriteBollardsRepository
    
    init(favoriteBollardsRepository: FavoriteBollardsRepository) {
        self.favoriteBollardsRepository = favoriteBollardsRepository
    }
    
    func handle(query: Query) -> Any {
        let observable = self.favoriteBollardsRepository.favoriteBollards()
        return observable
    }
}