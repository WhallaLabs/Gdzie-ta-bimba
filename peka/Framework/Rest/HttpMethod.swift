//
//  HttpMethod.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case DELETE = "DELETE"
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    
    func isSuccessResponse(statusCode: Int) -> Bool {
        guard let responseCode = HttpResponseCode(rawValue: statusCode) else {
            return false
        }
        switch self {
        case .DELETE:
            return [HttpResponseCode.OK, HttpResponseCode.NoContent].contains(responseCode)
        case .POST:
            return [HttpResponseCode.OK, HttpResponseCode.Created, HttpResponseCode.NoContent].contains(responseCode)
        default:
            return responseCode == HttpResponseCode.OK
        }
    }
}