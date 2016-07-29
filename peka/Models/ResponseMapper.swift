//
//  ResponseMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class ResponseMapper<T: ObjectMappable>: ObjectMappable {
    private let mapper: T
    
    init(_ mapper: T) {
        self.mapper = mapper
    }
    
    func mapToObject(json: JSON) -> T.T? {
        return mapper.mapToObject(json["success"])
    }
}