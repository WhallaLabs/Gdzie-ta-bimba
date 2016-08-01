//
//  FormUrlEncodedBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class FormUrlEncodedBuilder: FormBodyBuilder {
    func prepareHeaders() -> [String : String] {
        return ["Content-Type" : "application/x-www-form-urlencoded"]
    }
    
    func createBody(parameters: [HttpBodyParameter]) -> NSData {
        let stringData = parameters.map(BodyParameterToKeyValueString()).joinWithSeparator("&")
        let data = stringData.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        return data
    }
}

private class BodyParameterToKeyValueString: Convertible {
    func convert(value: HttpBodyParameter) -> String {
        guard case .Form(let name, let value) = value else {
            return String.empty
        }
        return "\(name)=\(value)"
    }
}