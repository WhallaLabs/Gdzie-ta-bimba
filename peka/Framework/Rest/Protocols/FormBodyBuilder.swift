//
//  FormBodyBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

protocol FormBodyBuilder {
    func prepareHeaders() -> [String : String]
    func createBody(_ parameters: [HttpBodyParameter]) -> Data
}
