//
//  MultipartFormBodyBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class MultipartFormBodyBuilder: FormBodyBuilder {
    private let boundary = "Boundary-\(NSUUID().UUIDString)"
    
    func prepareHeaders() -> [String : String] {
        return ["Content-Type" : "multipart/form-data; boundary=\(self.boundary)"]
    }
    
    func createBody(parameters: [HttpBodyParameter]) -> NSData {
        let body = NSMutableData()
        
        for parameter in parameters {
            body.appendString("--\(self.boundary)\r\n")
            switch parameter {
            case .Form(let name, let value):
                body.appendString("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
                body.appendString(value)
            case .File(let name, let data, let fileName, let mime):
                body.appendString("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n")
                body.appendString("Content-Type: \(mime)\r\n\r\n")
                body.appendData(data)
            }
            body.appendString("\r\n")
        }
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
}