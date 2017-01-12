//
//  FavoriteViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class FavoriteViewConfigurator: NSObject {

	@IBOutlet fileprivate weak var viewController: FavoriteViewController!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
	func configure() {
		self.tableView.register(BollardCell.self)
        self.viewController.updateTitle("Moje przystanki")
	}
}
