//
//  DirectionHeader.swift
//  peka
//
//  Created by Tomasz Pikć on 05/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class DirectionHeader: UITableViewHeaderFooterView {
    @IBOutlet private weak var routeTypeIcon: UIImageView!
    @IBOutlet private weak var directionLabel: UILabel!
    private let lineNameToRouteTypeConverter = LineNameToRouteTypeConverter()
    private let routeTypeToImageConverter = RouteTypeToIconImageConverter()
    
    func configure(direction: Direction) {
        self.directionLabel.text = "➙ \(direction.directionName)"
        let routeType = self.lineNameToRouteTypeConverter.convert(direction.line)
        self.routeTypeIcon.image = self.routeTypeToImageConverter.convert(routeType)
        
    }
}

extension DirectionHeader: NibLoadableView {
    
}