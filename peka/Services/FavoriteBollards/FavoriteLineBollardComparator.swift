//
//  FavoriteLineBollardComparator.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class FavoriteLineBollardComparator {
    
    private let favoriteBollardsRepository: FavoriteBollardsRepository
    
    init(favoriteBollardsRepository: FavoriteBollardsRepository) {
        self.favoriteBollardsRepository = favoriteBollardsRepository
    }
    
    func checkFavorite(observable: Observable<[LineBollards]>) -> Observable<[LineBollards]> {
        return Observable.combineLatest(observable, self.favoriteBollardsRepository.favoriteBollards()) { lineBollards, favouriteBollards in
            var result: [LineBollards] = []
            for lineBollard in lineBollards {
                let bollards = lineBollard.bollards.replaceElements(favouriteBollards)
                result.append(LineBollards(direction: lineBollard.direction, bollards: bollards))
            }
            return result
        }.shareReplayLatestWhileConnected()
    }
}