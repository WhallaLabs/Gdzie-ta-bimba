//
//  FavoriteSection.swift
//  peka
//
//  Created by Tomasz Pikć on 13/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RxDataSources

struct FavoriteSection: AnimatableSectionModelType {
    typealias Item = StopPointType

    let items: [StopPointType]
    
    let identity: FavoriteSectionType
    
    init(original: FavoriteSection, items: [StopPointType]) {
        self.items = items
        self.identity = original.identity
    }
    
    init(nearestStopPoints: [StopPointPushpin]) {
        self.items = nearestStopPoints.map { StopPointType.nearest(stopPoint: $0) }
        self.identity = .nearest
    }
    
    init(favorite: [Bollard]) {
        self.items = favorite.map { StopPointType.favorite(bollard: $0) }
        self.identity = .favorite
    }
}

enum FavoriteSectionType: Int {
    case nearest = 1
    case favorite = 2
}

extension FavoriteSection: ImageHeaderModelType {
    var image: ImageAssets {
        switch self.identity {
        case .favorite:
            return .favorite
        case .nearest:
            return .gps
        }
    }
    
    var text: String {
        switch self.identity {
        case .favorite:
            return "Favorite".localized
        case .nearest:
            return "NearestStops".localized
        }
    }
}
