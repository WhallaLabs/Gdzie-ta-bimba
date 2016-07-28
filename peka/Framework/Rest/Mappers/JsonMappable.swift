//
//  JsonMappable.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JsonMappable {
    associatedtype T
    func mapToJson(object: T) -> JSON?
}