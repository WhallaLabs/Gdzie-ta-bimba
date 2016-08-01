//
//  SearchViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: SearchViewModel!
    private var navigationDelegate: SearchNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: SearchViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    private var searchBar: UISearchBar {
        return self.viewConfigurator.searchBar
    }
    
	func installDependencies(viewModel: SearchViewModel, _ navigationDelegate: SearchNavigationControllerDelegate) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.viewModel.initializeSearch().addDisposableTo(self.disposables)
        self.resigsterForEvents()
	}
	
    private func setupBinding() {
        self.searchBar.rx_text.bindTo(self.viewModel.searchPhrase)
            .addDisposableTo(self.disposables)
        
        self.viewModel.searchResult.bindTo(self.tableView.configurableCells(SearchResultCell.self))
            .addDisposableTo(self.disposables)
    }
    
    private func resigsterForEvents() {
        self.tableView.rx_modelSelected(SearchResult.self)
            .subscribeNext { [unowned self] searchResult in
                self.navigationDelegate.showBollards(searchResult)
            }.addDisposableTo(self.disposables)
        
        Observable.of(self.searchBar.rx_searchButtonClicked, self.searchBar.rx_cancelButtonClicked).merge()
            .subscribeNext { [unowned self] in
                self.searchBar.resignFirstResponder()
            }.addDisposableTo(self.disposables)
    }
}
