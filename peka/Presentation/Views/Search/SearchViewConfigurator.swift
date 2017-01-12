//
//  SearchViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchViewConfigurator: NSObject {

	@IBOutlet fileprivate weak var viewController: SearchViewController!
    @IBOutlet fileprivate weak var tableView: UITableView!

	func configure() {
        self.tableView.register(SearchResultCell.self)
        self.viewController.updateTitle("")
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(-20, 0, 0, 0)
	}
}
