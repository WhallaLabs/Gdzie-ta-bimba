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
    @IBOutlet private weak var emptyStateLabel: UILabel!
    @IBOutlet private weak var editButton: UIBarButtonItem!
    
	func configure() {
		self.tableView.register(BollardCell.self)
        self.tableView.register(StopPointCell.self)
        self.tableView.register(ImageHeaderView.self)
        self.viewController.updateTitle("MyStops".localized)
        self.emptyStateLabel.text = "Favorite:EmptyState".localized
        self.editButton.title = "Edit".localized
	}
}
