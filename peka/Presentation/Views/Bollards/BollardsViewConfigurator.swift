//
//  BollardsViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class BollardsViewConfigurator: NSObject {

	@IBOutlet fileprivate weak var viewController: BollardsViewController!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
	func configure() {
		self.tableView.register(GroupedDirectionsCell.self)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 56.0
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
	}
}
