//
//  StopPointTypeToBollardConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 20/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation

final class StopPointTypeToBollardConverter: Convertible {
    func convert(_ value: StopPointType) -> Bollard? {
        guard case .favorite(let bollard) = value else {
            return nil
        }
        return bollard
    }
}
