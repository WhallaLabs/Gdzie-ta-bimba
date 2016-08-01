//
//  GroupedDirectionsCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class GroupedDirectionsCell: UITableViewCell {
    
}

extension GroupedDirectionsCell: NibLoadableView {

}

extension GroupedDirectionsCell: Configurable {
	func configure(model: GroupedDirections) {
        let directions = model.directions.map { $0.description }
        self.textLabel?.text = directions.joinWithSeparator(", ")
    }
}