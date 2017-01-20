//
//  RealmFavoriteBollardsRepository.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class RealmFavoriteBollardsRepository: FavoriteBollardsRepository {
    
    fileprivate let realm = try! Realm()
    
    func favoriteBollards() -> Observable<[Bollard]> {
        
        return Observable.arrayFrom(realm.objects(BollardRealm.self))
            .map(BollardsRealmToBollardsMapper())
            .shareReplayLatestWhileConnected()
    }
    
    func add(_ bollard: Bollard) {
        let bollardRealm = self.mapToRealmObject(bollard)
        try! self.realm.write {
            self.realm.add(bollardRealm)
        }
    }
    
    func remove(_ bollard: Bollard) -> Bool {
        guard let bollardRealm = self.realm.object(ofType: BollardRealm.self, forPrimaryKey: bollard.symbol) ?? self.realm.object(ofType: BollardRealm.self, forPrimaryKey: bollard.tag) else {
            return false
        }
        try! self.realm.write {
            self.realm.delete(bollardRealm)
        }
        return true
    }
    
    fileprivate func mapToRealmObject(_ bollard: Bollard) -> BollardRealm {
        let mapper = BollardToBollardRealmMapper()
        let bollardRealm = mapper.convert(bollard)
        return bollardRealm
    }
}
