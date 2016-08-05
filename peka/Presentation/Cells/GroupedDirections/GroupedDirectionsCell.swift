//
//  GroupedDirectionsCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol GroupedDirectionsCellDelegate: class {
    func toggleFavorite(bollard: Bollard)
}

final class GroupedDirectionsCell: UITableViewCell {
    @IBOutlet private weak var directionsLabel: UILabel!
    @IBOutlet private weak var roundBackgroundView: UIView!
    @IBOutlet private weak var favoriteButton: UIButton!
    private let converter = FavoriteStateToImageConverter()
    
    private var bollard: Bollard!
    
    weak var delegate: GroupedDirectionsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    @IBAction private func toggleFavorite() {
        self.delegate?.toggleFavorite(self.bollard)
    }
    
    private func directionAttributedString(direction: Direction, appendSeperator: Bool) -> NSAttributedString {
        let directionDescription: NSString = "\(direction.description)\(appendSeperator ? "\u{00a0}⋮ " : String.empty)"
        let lineRange = directionDescription.rangeOfString(direction.line)
        let attributedString = AttributedTextBuilder(string: directionDescription as String)
            .setFont(UIFont.systemFontOfSize(14, weight: UIFontWeightMedium))
            .setColor(UIColor(color: .MainLight))
            .setFont(UIFont.systemFontOfSize(14, weight: UIFontWeightBold), textRange: lineRange)
            .setColor(UIColor(argbHex: 0xFF718EA6), textRange: lineRange)
            .attributedText
        return attributedString
    }
}

extension GroupedDirectionsCell: NibLoadableView {

}

extension GroupedDirectionsCell: Configurable {
	func configure(model: GroupedDirections) {
        self.bollard = model.bollard
        let attributedString = NSMutableAttributedString()
        for (index, direction) in model.directions.enumerate() {
            let directionString = self.directionAttributedString(direction, appendSeperator: index < model.directions.count - 1)
            attributedString.appendAttributedString(directionString)
        }
        self.directionsLabel.attributedText = attributedString
        
        self.favoriteButton.setImage(self.converter.convert(model.bollard), forState: .Normal)
    }
}