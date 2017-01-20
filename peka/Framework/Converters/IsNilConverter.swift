//
//  IsNilConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 15/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxOptional

final class IsNilConverter<T: OptionalType>: Convertible {
    func convert(_ value: T) -> Bool {
        return value.value == nil
    }
}
