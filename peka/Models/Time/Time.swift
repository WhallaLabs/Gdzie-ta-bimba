//
//  Time.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

struct Time: DirectionDescription {
    let departure: NSDate
    let directionName: String
    let line: String
    let minutes: Int
    let onStopPoint: Bool
    let realTime: Bool
}