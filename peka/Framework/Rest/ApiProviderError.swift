//
//  ApiProviderError.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

enum ApiProviderError: ErrorType {
    case HttpError(status: Int, json: JSON)
    case JsonMapping
    case NoResponse
}