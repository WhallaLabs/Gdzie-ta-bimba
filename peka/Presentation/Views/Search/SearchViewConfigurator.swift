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
    
    let searchBar: UISearchBar = UISearchBar()

	func configure() {
        self.tableView.register(SearchResultCell.self)
        self.addSearchBar()
	}
    
    private func addSearchBar() {
        //let searchController = UISearchController(searchResultsController: nil)
        //self.searchBar = searchController.searchBar
        self.searchBar.placeholder = "Szukaj przystanków, linii lub ulic"
        self.viewController.navigationItem.titleView = self.searchBar
    }
}
