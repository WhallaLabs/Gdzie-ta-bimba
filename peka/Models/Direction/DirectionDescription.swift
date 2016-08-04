//
//  DirectionDescription.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

protocol DirectionDescription {
    var line: String { get }
    var directionName: String { get }
}

extension DirectionDescription {
    var description: String {
        return "\(self.line)\u{00a0}➙\u{00a0}\(self.directionName)"
    }
}