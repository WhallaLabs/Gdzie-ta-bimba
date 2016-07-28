//
//  NoContentMapper.swift
//  kuchniaikropka
//
//  Created by Pawel Urbanowicz on 11.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import SwiftyJSON

final class NoContentMapper: ObjectMappable {
    func mapToObject(json: JSON) -> Void? {
        return ()
    }
}