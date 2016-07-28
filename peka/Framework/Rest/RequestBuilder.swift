//
//  RequestBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BodyRequestBuilder {
    var url: String { get }
    var httpMethod: HttpMethod { get }
    func add(json json: JSON?) -> BodyRequestBuilder
    func add(headers headers: [String: String]) -> BodyRequestBuilder
    func getRequest() -> NSMutableURLRequest
    func setMethod(method: HttpMethod) -> BodyRequestBuilder
}

protocol QueryRequestBuilder: BodyRequestBuilder {
    func add(resource resource: String) -> QueryRequestBuilder
    func add(pathParameter pathParameter: String?) -> QueryRequestBuilder
    func add(queryParameters queryParameters: [String: String]) -> BodyRequestBuilder
    func add(bodyParameters parameters: [HttpBodyParameter]) -> BodyRequestBuilder
}

final class RequestBuilder: QueryRequestBuilder {
    
    private var request: NSMutableURLRequest?
    private(set) var url: String
    private(set) var httpMethod: HttpMethod
    
    init(endpoint: String, method: HttpMethod = .GET) {
        self.url = endpoint
        self.httpMethod = method
    }
    
    func add(resource resource: String) -> QueryRequestBuilder {
        self.url.appendPathComponent(resource)
        return self
    }
    
    func add(pathParameter pathParameter: String?) -> QueryRequestBuilder {
        if let pathParameter = pathParameter {
            self.url.appendPathComponent(pathParameter)
        }
        return self
    }
    
    func add(queryParameters queryParameters: [String: String]) -> BodyRequestBuilder {
        if queryParameters.count > 0 {
            let query = queryParameters.map { "\($0.0)=\($0.1)" }
                .joinWithSeparator("&")
            self.url += "?" + query.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        }
        return self
    }
    
    func add(json json: JSON?) -> BodyRequestBuilder {
        self.getRequest()
        if let jsonObject = json {
            if let data = try? jsonObject.rawData() {
                self.request!.HTTPBody = data
            }
        }
        return self
    }
    
    func add(bodyParameters parameters: [HttpBodyParameter]) -> BodyRequestBuilder {
        self.getRequest()
        let boundary = "Boundary-\(NSUUID().UUIDString)"
        
        self.request!.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        self.request!.HTTPBody = self.createBody(withBoundary: boundary, andParameters: parameters)
        
        return self
    }
    
    func add(headers headers: [String: String]) -> BodyRequestBuilder {
        self.getRequest()
        for header: (name: String, value: String) in headers {
            if request!.valueForHTTPHeaderField(header.name) == nil {
                request!.addValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        return self
    }
    
    func setMethod(method: HttpMethod) -> BodyRequestBuilder {
        self.getRequest()
        self.httpMethod = method
        self.request!.HTTPMethod = method.rawValue
        
        return self
    }
    
    func getRequest() -> NSMutableURLRequest {
        if self.request == nil {
            self.request = NSMutableURLRequest(URL: NSURL(string: self.url)!)
            self.request!.HTTPMethod = self.httpMethod.rawValue
        }
        return self.request!
    }
    
    private func createBody(withBoundary boundary: String, andParameters parameters: [HttpBodyParameter]) -> NSData {
        let body = NSMutableData()
        
        for parameter in parameters {
            body.appendString("--\(boundary)\r\n")
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