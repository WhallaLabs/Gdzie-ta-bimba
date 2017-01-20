//
//  RequestBodyBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class RequestBodyBuilder {
    func search(_ methodName: SearchMethod, pattern: String) -> [HttpBodyParameter] {
        let patternJson = self.patternJson(pattern)
        return self.methodParamter(methodName, value: patternJson)
    }
    
    func getBollardsByStopPoint(_ name: String) -> [HttpBodyParameter] {
        let nameJson = self.nameJson(name)
        return self.methodParamter(ApiConfig.getBollardsByStopPoint, value: nameJson)
    }
    
    func getBollardsByLine(_ name: String) -> [HttpBodyParameter] {
        let nameJson = self.nameJson(name)
        return self.methodParamter(ApiConfig.getBollardsByLine, value: nameJson)
    }
    
    func getBollardsByStreet(_ name: String) -> [HttpBodyParameter] {
        let nameJson = self.nameJson(name)
        return self.methodParamter(ApiConfig.getBollardsByStreet, value: nameJson)
    }
    
    func getTimes(_ bollardSymbol: String) -> [HttpBodyParameter] {
        let symbolJson = self.symbolJson(bollardSymbol)
        return self.methodParamter(ApiConfig.getTimes, value: symbolJson)
    }
    
    func bollardMessage(_ bollardSymbol: String) -> [HttpBodyParameter] {
        let symbolJson = self.symbolJson(bollardSymbol)
        return self.methodParamter(ApiConfig.findMessagesForBollard, value: symbolJson)
    }
    
    fileprivate func patternJson(_ pattern: String) -> String {
        return "{\"pattern\":\"\(pattern)\"}"
    }
    
    fileprivate func nameJson(_ name: String) -> String {
        return "{\"name\":\"\(name)\"}"
    }
    
    fileprivate func symbolJson(_ name: String) -> String {
        return "{\"symbol\":\"\(name)\"}"
    }
    
    fileprivate func methodParamter(_ methodName: String, value: String) -> [HttpBodyParameter] {
        return [.form(name: "p0", value: value), .form(name: "method", value: methodName)]
    }
}
