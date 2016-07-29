//
//  RequestBodyBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class RequestBodyBuilder {
    func search(methodName: String, pattern: String) -> [HttpBodyParameter] {
        let patternJson = self.patternJson(pattern)
        return self.methodParamter(methodName, value: patternJson)
    }
    
    private func patternJson(pattern: String) -> String {
        return "{\"pattern\":\"\(pattern)\"}"
    }
    
    private func methodParamter(methodName: String, value: String) -> [HttpBodyParameter] {
        return [.Form(name: "method", value: methodName), .Form(name: "p0", value: value)]
    }
}