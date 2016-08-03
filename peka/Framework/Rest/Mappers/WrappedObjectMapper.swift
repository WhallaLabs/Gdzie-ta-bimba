//
//  WrappedObjectMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class WrappedObjectMapper<T: ObjectMappable>: ObjectMappable {
    private let mapper: T
    private let pathToObject: [String]
    
    init(_ mapper: T, pathToObject: String...) {
        self.mapper = mapper
        self.pathToObject = pathToObject
    }
    
    func mapToObject(json: JSON) -> T.T? {
        var json = json
        for field in self.pathToObject {
            json = json[field]
        }
        return mapper.mapToObject(json)
    }
}