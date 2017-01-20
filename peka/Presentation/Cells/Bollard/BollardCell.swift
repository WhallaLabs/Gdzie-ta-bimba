//
//  BollardCell.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol BollardCellDelegate: class {
    func toggleFavorite(_ bollard: Bollard)
}

final class BollardCell: UITableViewCell {
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var symbolLabel: UILabel!
    @IBOutlet fileprivate weak var favoriteButton: UIButton!
    fileprivate let favoriteStateToImageConverter = FavoriteStateToImageConverter()
    fileprivate var bollard: Bollard!
    
    weak var delegate: BollardCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    @IBAction fileprivate func toggleFavorite() {
        self.delegate?.toggleFavorite(self.bollard)
    }
}

extension BollardCell: NibLoadableView {

}

extension BollardCell: Configurable {
	func configure(_ model: Bollard) {
        self.bollard = model
        self.nameLabel.text = model.name
        self.symbolLabel.text = model.symbol
        
        self.favoriteButton.setImage(self.favoriteStateToImageConverter.convert(model), for: UIControlState())
    }
}
