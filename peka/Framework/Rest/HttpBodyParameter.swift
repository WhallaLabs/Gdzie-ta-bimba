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