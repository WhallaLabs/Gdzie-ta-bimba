//
//  ToOptionalConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 15/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class ToOptionalConverter<T>: Convertible {
    func convert(_ value: T) -> T? {
        return value
    }
}
