//
//  BollardCell.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class BollardCell: UITableViewCell {
    
}

extension BollardCell: NibLoadableView {

}

extension BollardCell: Configurable {
	func configure(model: Bollard) {
        self.textLabel?.text = model.name
    }
}