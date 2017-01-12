//
//  RawJsonMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class RawJsonMapper: ObjectMappable {
    
    func mapToObject(_ json: JSON) -> JSON? {
    	return json
    }
}
