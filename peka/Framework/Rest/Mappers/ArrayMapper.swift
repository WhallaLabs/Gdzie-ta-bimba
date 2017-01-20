//
//  ArrayMapper.swift
//  kuchniaikropka
//
//  Created by Norbert Sroczynski on 18.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

final class ArrayMapper<U: ObjectMappable>: ObjectMappable {
    let mapper: U
    
    init(_ mapper: U) {
        self.mapper = mapper
    }
    
    func mapToObject(_ json: JSON) -> [U.T]? {
        guard let array = json.array else {
            return nil
        }
        return array.flatMap { self.mapper.mapToObject($0) }
    }
}
