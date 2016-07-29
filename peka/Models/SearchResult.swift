//
//  SearchResult.swift
//  peka
//
//  Created by Tomasz Pikć on 29/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

enum SearchResult {
    case Stop(model: StopPoint)
    case Street(name: String)
    case Line(name: String)
}