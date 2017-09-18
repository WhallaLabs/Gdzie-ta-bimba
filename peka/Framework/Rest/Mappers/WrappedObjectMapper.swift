//
//  WrappedObjectMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class WrappedObjectMapper<Mapper: ObjectMappable>: ObjectMappable {
    fileprivate let mapper: Mapper
    fileprivate let pathToObject: [String]
    
    init(_ mapper: Mapper, pathToObject: String...) {
        self.mapper = mapper
        self.pathToObject = pathToObject
    }
    
    func mapToObject(_ json: JSON) -> Mapper.T? {
        var json = json
        for field in self.pathToObject {
            json = json[field]
        }
        return mapper.mapToObject(json)
    }
}
