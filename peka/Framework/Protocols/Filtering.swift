//
//  Filtering.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

protocol Filtering {
    associatedtype T
    func filter(value: T) -> Bool
}