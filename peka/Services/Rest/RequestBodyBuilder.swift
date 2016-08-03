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
    
    func getBollardsByStopPoint(name: String) -> [HttpBodyParameter] {
        let nameJson = self.nameJson(name)
        return self.methodParamter("getBollardsByStopPoint", value: nameJson)
    }
    
    func getBollardsByLine(name: String) -> [HttpBodyParameter] {
        let nameJson = self.nameJson(name)
        return self.methodParamter("getBollardsByLine", value: nameJson)
    }
    
    func getBollardsByStreet(name: String) -> [HttpBodyParameter] {
        let nameJson = self.nameJson(name)
        return self.methodParamter("getBollardsByStreet", value: nameJson)
    }
    
    func getTimes(bollardSymbol: String) -> [HttpBodyParameter] {
        let symbolJson = self.symbolJson(bollardSymbol)
        return self.methodParamter("getTimes", value: symbolJson)
    }
    
    private func patternJson(pattern: String) -> String {
        return "{\"pattern\":\"\(pattern)\"}"
    }
    
    private func nameJson(name: String) -> String {
        return "{\"name\":\"\(name)\"}"
    }
    
    private func symbolJson(name: String) -> String {
        return "{\"symbol\":\"\(name)\"}"
    }
    
    private func methodParamter(methodName: String, value: String) -> [HttpBodyParameter] {
        return [.Form(name: "p0", value: value), .Form(name: "method", value: methodName)]
    }
}