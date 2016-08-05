//
//  RouteTypeToIconImageConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class RouteTypeToIconImageConverter: Convertible {
    private let tramImage =  UIImage(asset: .Tram)
    private let busImage = UIImage(asset: .Bus)
    
    func convert(value: RouteType) -> UIImage {
        switch value {
        case .Bus:
            return self.busImage
        case .Tram:
            return self.tramImage
        }
    }
}