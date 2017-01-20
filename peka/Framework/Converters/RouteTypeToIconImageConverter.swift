//
//  RouteTypeToIconImageConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class RouteTypeToIconImageConverter: Convertible {
    fileprivate let tramImage =  UIImage(asset: .Tram)
    fileprivate let busImage = UIImage(asset: .Bus)
    
    func convert(_ value: RouteType) -> UIImage {
        switch value {
        case .bus:
            return self.busImage
        case .tram:
            return self.tramImage
        }
    }
}
