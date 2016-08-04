//
//  SearchResultCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    @IBOutlet private weak var roundBackgroundView: UIView!
    @IBOutlet private weak var iconImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
}

extension SearchResultCell: NibLoadableView {

}

extension SearchResultCell: Configurable {
    func configure(model: SearchResult) {
        switch model {
        case .Line(let name):
            self.nameLabel.text = name
            self.iconImage.image = UIImage(asset: .Tram)
        case .Stop(let model):
            self.nameLabel.text = model.name
            self.iconImage.image = UIImage(asset: .PushpinEmpty)
        case .Street(let name):
            self.nameLabel.text = name
            self.iconImage.image = UIImage(asset: .Bus)
        }
    }
}