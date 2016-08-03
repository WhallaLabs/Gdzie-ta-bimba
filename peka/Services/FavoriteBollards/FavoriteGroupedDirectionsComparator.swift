//
//  FavoriteGroupedDirectionsComparator.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

final class FavoriteGroupedDirectionsComparator {
    
    private let favouriteBollardsRepository: FavoriteBollardsRepository
    
    init(favouriteBollardsRepository: FavoriteBollardsRepository) {
        self.favouriteBollardsRepository = favouriteBollardsRepository
    }
    
    func checkFavourite(observable: Observable<[GroupedDirections]>) -> Observable<[GroupedDirections]> {
        return Observable.combineLatest(observable, self.favouriteBollardsRepository.favoriteBollards()) { groupedDirections, favouriteBollards in
            var result: [GroupedDirections] = []
            for groupedDirection in groupedDirections {
                if let index = favouriteBollards.indexOf(groupedDirection.bollard) {
                    let bollard = favouriteBollards[index]
                    result.append(GroupedDirections(bollard: bollard, directions: groupedDirection.directions))
                } else {
                    result.append(groupedDirection)
                }
            }
            return result
        }.shareReplayLatestWhileConnected()
    }
}