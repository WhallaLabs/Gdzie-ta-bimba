//
//  BollardViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class BollardViewConfigurator: NSObject {

	@IBOutlet fileprivate weak var viewController: BollardViewController!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var toggleFavoriteButton: UIBarButtonItem!
    
	func configure() {
		self.tableView.register(TimeCell.self)
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
	}
}
