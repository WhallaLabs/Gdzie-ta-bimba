//
//  SearchViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: SearchViewController!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyStateLabel: UILabel!
    @IBOutlet private weak var noResultsOpsLabel: UILabel!
    @IBOutlet private weak var noResultsLabel: UILabel!

	func configure() {
        self.tableView.register(SearchResultCell.self)
        self.viewController.updateTitle("")
        self.tableView.contentInset = .zero
        self.tableView.scrollIndicatorInsets = .zero
        
        self.emptyStateLabel.text = "Search:EmptyState".localized
        self.noResultsOpsLabel.text = "Search:NoResultsHeader".localized
        self.noResultsLabel.text = "Search:NoResults".localized
	}
}
