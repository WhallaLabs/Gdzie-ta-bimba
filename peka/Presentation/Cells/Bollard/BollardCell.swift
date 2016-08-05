//
//  BollardCell.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol BollardCellDelegate: class {
    func toggleFavorite(bollard: Bollard)
}

final class BollardCell: UITableViewCell {
    @IBOutlet private weak var roundBackgroundView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    private let favoriteStateToImageConverter = FavoriteStateToImageConverter()
    private var bollard: Bollard!
    
    weak var delegate: BollardCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    @IBAction private func toggleFavorite() {
        self.delegate?.toggleFavorite(self.bollard)
    }
}

extension BollardCell: NibLoadableView {

}

extension BollardCell: Configurable {
	func configure(model: Bollard) {
        self.bollard = model
        self.nameLabel.text = model.name
        self.symbolLabel.text = model.symbol
        
        self.favoriteButton.setImage(self.favoriteStateToImageConverter.convert(model), forState: .Normal)
    }
}