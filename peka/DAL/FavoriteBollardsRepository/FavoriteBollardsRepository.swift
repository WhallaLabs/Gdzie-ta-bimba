//
//  FavoriteBollardsRepository.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteBollardsRepository {
    func favoriteBollards() -> Observable<[Bollard]>
    func remove(_ bollard: Bollard) -> Bool
    func add(_ bollard: Bollard)
    func updateMany(bollards: [Bollard])
}
