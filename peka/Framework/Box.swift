//
//  Box.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class Box<T> {
    var value: T
    init(_ value: T) {
        self.value = value
    }
}