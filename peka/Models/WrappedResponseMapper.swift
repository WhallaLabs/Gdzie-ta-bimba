//
//  WrappedResponseMapperMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class WrappedResponseMapperMapper<T: ObjectMappable>: ObjectMappable {
    
    private let mapper: T
    private let rootFieldName: String
    
    init(_ rootFieldName: String, mapper: T) {
        self.rootFieldName = rootFieldName
        self.mapper = mapper
    }
    
    func mapToObject(json: JSON) -> [T.T]? {
        let arrayMapper = ArrayMapper(self.mapper)
        
        return arrayMapper.mapToObject(json["success"][self.rootFieldName])
    }
}