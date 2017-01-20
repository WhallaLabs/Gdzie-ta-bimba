//
//  MultipartFormBodyBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class MultipartFormBodyBuilder: FormBodyBuilder {
    fileprivate let boundary = "Boundary-\(UUID().uuidString)"
    
    func prepareHeaders() -> [String : String] {
        return ["Content-Type" : "multipart/form-data; boundary=\(self.boundary)"]
    }
    
    func createBody(_ parameters: [HttpBodyParameter]) -> Data {
        let body = NSMutableData()
        
        for parameter in parameters {
            body.appendString("--\(self.boundary)\r\n")
            switch parameter {
            case .form(let name, let value):
                body.appendString("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n")
                body.appendString(value)
            case .file(let name, let data, let fileName, let mime):
                body.appendString("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n")
                body.appendString("Content-Type: \(mime)\r\n\r\n")
                body.append(data)
            }
            body.appendString("\r\n")
        }
        body.appendString("--\(boundary)--\r\n")
        
        return body as Data
    }
}
