//
//  TimeCell.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class TimeCell: UITableViewCell {
    
}

extension TimeCell: NibLoadableView {

}

extension TimeCell: Configurable {
	func configure(model: Time) {
        self.textLabel?.text = "\(model.description) # \(model.minutes)min. \(model.realTime)"
    }
}