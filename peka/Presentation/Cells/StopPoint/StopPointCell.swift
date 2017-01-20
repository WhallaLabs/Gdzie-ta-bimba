//
//  StopPointCell.swift
//  peka
//
//  Created by Tomasz Pikć on 13/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

final class StopPointCell: UITableViewCell {
    fileprivate let routeTypeToImageConverter = RouteTypeToIconImageConverter()
    
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var linesLabel: UILabel!
    @IBOutlet fileprivate weak var firstRouteType: UIImageView!
    @IBOutlet fileprivate weak var secondRouteType: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }
    
    fileprivate func configure() {
        self.alpha = 0
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    fileprivate func configureRouteTypesIcons(_ routeTypes: [RouteType]) {
        let imageViews = [self.firstRouteType, self.secondRouteType]
        imageViews.forEach { $0?.isHidden = true }
        let routeTypesEnumerate = routeTypes.distinct().take(2).enumerated()
        for (index, routeType) in routeTypesEnumerate {
            let imageView = imageViews[index]!
            imageView.isHidden = false
            imageView.image = self.routeTypeToImageConverter.convert(routeType)
        }
    }
}

extension StopPointCell: NibLoadableView {

}

extension StopPointCell: Configurable {
	func configure(_ model: StopPointPushpin) {
        self.nameLabel.text = model.name
        self.linesLabel.text = model.headsigns
        self.configureRouteTypesIcons(model.routeTypes)
    }
}
