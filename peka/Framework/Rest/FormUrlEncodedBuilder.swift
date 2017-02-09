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
        return ["Content-Type" : "application/x-www-form-urlencoded; charset=UTF-8"]
    }
    
    func createBody(_ parameters: [HttpBodyParameter]) -> Data {
        let stringData = parameters.map(BodyParameterToKeyValueString()).joined(separator: "&")
        let data = stringData.data(using: String.Encoding.utf8, allowLossyConversion: true)!
        return data
    }
}

private class BodyParameterToKeyValueString: Convertible {
    func convert(_ value: HttpBodyParameter) -> String {
        guard case .form(let name, let value) = value else {
            return String.empty
        }
        return "\(name)=\(value)"
    }
}
