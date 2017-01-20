//
//  DirectionHeader.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class DirectionHeader: UITableViewHeaderFooterView {
    @IBOutlet fileprivate weak var routeTypeIcon: UIImageView!
    @IBOutlet fileprivate weak var directionLabel: UILabel!
    fileprivate let lineNameToRouteTypeConverter = LineNameToRouteTypeConverter()
    fileprivate let routeTypeToImageConverter = RouteTypeToIconImageConverter()
    
    func configure(_ direction: Direction) {
        self.directionLabel.text = "➙ \(direction.directionName)"
        let routeType = self.lineNameToRouteTypeConverter.convert(direction.line)
        self.routeTypeIcon.image = self.routeTypeToImageConverter.convert(routeType)
        
    }
}

extension DirectionHeader: NibLoadableView {
    
}
