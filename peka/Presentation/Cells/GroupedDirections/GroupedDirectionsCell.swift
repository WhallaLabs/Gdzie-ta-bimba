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
        self.textLabel?.text = model.bollard.name
        let directions = model.directions.map { direction in "\(direction.line) ➙ \(direction.name)" }
        self.detailTextLabel?.text = directions.joinWithSeparator(", ")
    }
}