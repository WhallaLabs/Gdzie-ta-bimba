//
//  GroupedDirectionsCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol GroupedDirectionsCellDelegate: class {
    func toggleFavorite(_ bollard: Bollard)
}

final class GroupedDirectionsCell: UITableViewCell {
    @IBOutlet fileprivate weak var directionsLabel: UILabel!
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    fileprivate let converter = FavoriteStateToImageConverter()
    
    fileprivate var bollard: Bollard!
    
    weak var delegate: GroupedDirectionsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    @IBAction fileprivate func toggleFavorite() {
        self.delegate?.toggleFavorite(self.bollard)
    }
    
    fileprivate func directionAttributedString(_ direction: Direction, appendSeperator: Bool) -> NSAttributedString {
        let directionDescription = "\(direction.description)\(appendSeperator ? "\u{00a0}⋮ " : String.empty)"
        let lineRange = (directionDescription as NSString).range(of: direction.line)
        let attributedString = AttributedTextBuilder(string: directionDescription as String)
            .setFont(UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium))
            .setColor(UIColor(color: .mainLight))
            .setFont(UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold), textRange: lineRange)
            .setColor(UIColor(argbHex: 0xFF718EA6), textRange: lineRange)
            .attributedText
        return attributedString
    }
}

extension GroupedDirectionsCell: NibLoadableView {

}

extension GroupedDirectionsCell: Configurable {
	func configure(_ model: GroupedDirections) {
        self.bollard = model.bollard
        let attributedString = NSMutableAttributedString()
        for (index, direction) in model.directions.enumerated() {
            let directionString = self.directionAttributedString(direction, appendSeperator: index < model.directions.count - 1)
            attributedString.append(directionString)
        }
        self.directionsLabel.attributedText = attributedString
        
        self.favoriteButton.setImage(self.converter.convert(model.bollard), for: UIControlState())
    }
}
