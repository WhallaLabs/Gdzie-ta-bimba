//
//  FavoriteViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class FavoriteViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: FavoriteViewController!
    @IBOutlet private weak var tableView: UITableView!
    
	func configure() {
		self.tableView.register(BollardCell.self)
	}
}
