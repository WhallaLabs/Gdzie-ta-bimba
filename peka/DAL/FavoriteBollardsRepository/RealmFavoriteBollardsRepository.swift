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
    
    private let realm = try! Realm()
    
    func favoriteBollards() -> Observable<[Bollard]> {
        return realm.objects(BollardRealm.self)
            .asObservableArray()
            .map(BollardsRealmToBollardsMapper())
    }
    
    func favouriteBollard(symbol: String) -> Observable<Bollard> {
        guard let bollardRealm = self.realm.objectForPrimaryKey(BollardRealm.self, key: symbol) else {
            return Observable.empty()
        }
        let mapper = BollardRealmToBollardMapper()
        let bollard = mapper.convert(bollardRealm)
        return Observable.just(bollard)
    }
    
    func add(bollard: Bollard) {
        let bollardRealm = self.mapToRealmObject(bollard)
        try! self.realm.write {
            self.realm.add(bollardRealm)
        }
    }
    
    func remove(bollard: Bollard) -> Bool {
        guard let bollardRealm = self.realm.objectForPrimaryKey(BollardRealm.self, key: bollard.symbol) else {
            return false
        }
        try! self.realm.write {
            self.realm.delete(bollardRealm)
        }
        return true
    }
    
    func mapToRealmObject(bollard: Bollard) -> BollardRealm {
        let mapper = BollardToBollardRealmMapper()
        let bollardRealm = mapper.convert(bollard)
        return bollardRealm
    }
}