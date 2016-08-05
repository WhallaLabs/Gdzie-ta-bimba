//
//  FavoriteBollardComparator.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class FavoriteBollardComparator {
    
    private let favoriteBollardsRepository: FavoriteBollardsRepository
    
    init(favoriteBollardsRepository: FavoriteBollardsRepository) {
        self.favoriteBollardsRepository = favoriteBollardsRepository
    }
    
    func checkFavorite(observable: Observable<Bollard>) -> Observable<Bollard> {
        return Observable.combineLatest(observable, self.favoriteBollardsRepository.favoriteBollards()) { bollard, favouriteBollards in
            let favoriteBollard = favouriteBollards.firstOrDefault { $0.localId == bollard.localId }
            if let favoriteBollard = favoriteBollard {
                return favoriteBollard
            }
            return bollard
        }.shareReplayLatestWhileConnected()
    }
}