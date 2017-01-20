//
//  SearchResultCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var iconImage: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    fileprivate let lineNameToRouteTypeConverter = LineNameToRouteTypeConverter()
    fileprivate let routeTypeToImageConverter = RouteTypeToIconImageConverter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
}

extension SearchResultCell: NibLoadableView {

}

extension SearchResultCell: Configurable {
    func configure(_ model: SearchResult) {
        switch model {
        case .line(let name):
            self.nameLabel.text = name
            let routeType = self.lineNameToRouteTypeConverter.convert(name)
            self.iconImage.image = self.routeTypeToImageConverter.convert(routeType)
        case .stop(let model):
            self.nameLabel.text = model.name
            self.iconImage.image = UIImage(asset: .PushpinEmpty)
        case .street(let name):
            self.nameLabel.text = name
            self.iconImage.image = UIImage(asset: .Street)
        }
    }
}
