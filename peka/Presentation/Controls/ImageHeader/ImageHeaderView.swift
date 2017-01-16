//
//  ImageHeaderCell.swift
//  peka
//
//  Created by Tomasz Pikć on 13/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

protocol ImageHeaderModelType {
    var image: ImageAssets { get }
    var text: String { get }
}

struct ImageHeaderModel: ImageHeaderModelType {
    let image: ImageAssets
    let text: String
}

final class ImageHeaderView: UITableViewHeaderFooterView {
    @IBOutlet fileprivate weak var image: UIImageView!
    @IBOutlet fileprivate weak var label: UILabel!
    
}

extension ImageHeaderView: NibLoadableView {

}

extension ImageHeaderView: Configurable {
    func configure(_ model: ImageHeaderModelType) {
        self.image.image = UIImage(asset: model.image)
        self.label.text = model.text
    }
}
