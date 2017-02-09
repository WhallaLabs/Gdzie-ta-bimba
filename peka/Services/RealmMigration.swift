//
//  RealmMigration.swift
//  peka
//
//  Created by Tomasz Pikć on 20/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmMigration {
    class func performMigrations() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 2, migrationBlock: { migration, oldSchemaVersion in
            migration.enumerateObjects(ofType: BollardRealm.className()) { (oldObject, newObject) in
                if oldSchemaVersion < 2 {
                    newObject?["order"] = 0
                }
            }
        })
    }
}
