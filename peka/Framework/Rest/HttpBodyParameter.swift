//
//  HttpBodyParameter.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

enum HttpBodyParameter {
    case File(name: String, data: NSData, fileName: String, mime: String)
    case Form(name: String, value: String)
}

extension HttpBodyParameter: Hashable {
    var hashValue: Int {
        switch self {
        case .File(let name, _, _, _):
            return name.hashValue
        case .Form(let name, _):
            return name.hashValue
        }
    }
}

func ==(lhs: HttpBodyParameter, rhs: HttpBodyParameter) -> Bool {
    return lhs.hashValue == rhs.hashValue
}