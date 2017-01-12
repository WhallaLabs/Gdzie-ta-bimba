//
//  RequestBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

final class RequestBuilder: QueryRequestBuilder {
    
    fileprivate var request: NSMutableURLRequest?
    fileprivate(set) var url: String
    fileprivate(set) var httpMethod: HttpMethod
    fileprivate let formBodyBuilder: FormBodyBuilder
    
    init(endpoint: String, formBodyBuilder: FormBodyBuilder, method: HttpMethod = .GET) {
        self.url = endpoint
        self.httpMethod = method
        self.formBodyBuilder = formBodyBuilder
    }
    
    func add(resource: String) -> QueryRequestBuilder {
        self.url.appendPathComponent(resource)
        return self
    }
    
    func add(pathParameter: String?) -> QueryRequestBuilder {
        if let pathParameter = pathParameter {
            self.url.appendPathComponent(pathParameter)
        }
        return self
    }
    
    func add(queryParameters: [String: String]) -> BodyRequestBuilder {
        if queryParameters.count > 0 {
            let query = queryParameters.map { "\($0.0)=\($0.1)" }
                .joined(separator: "&")
            self.url += "?" + query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        }
        return self
    }
    
    func add(json: JSON?) -> BodyRequestBuilder {
        self.getRequest()
        if let jsonObject = json {
            if let data = try? jsonObject.rawData() {
                self.request!.httpBody = data
            }
        }
        return self
    }
    
    func add(bodyParameters parameters: [HttpBodyParameter]) -> BodyRequestBuilder {
        self.getRequest()
        let headers = self.formBodyBuilder.prepareHeaders()
        for (key, value) in headers {
            self.request!.setValue(value, forHTTPHeaderField: key)
        }
        self.request!.httpBody = self.formBodyBuilder.createBody(parameters)
        
        return self
    }
    
    func add(headers: [String: String]) -> BodyRequestBuilder {
        self.getRequest()
        for header in headers {
            if request!.value(forHTTPHeaderField: header.key) == nil {
                request!.addValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        return self
    }
    
    func setMethod(_ method: HttpMethod) -> BodyRequestBuilder {
        self.getRequest()
        self.httpMethod = method
        self.request!.httpMethod = method.rawValue
        
        return self
    }
    
    func getRequest() -> NSMutableURLRequest {
        if self.request == nil {
            self.request = NSMutableURLRequest(url: URL(string: self.url)!)
            self.request!.httpMethod = self.httpMethod.rawValue
        }
        return self.request!
    }
}
