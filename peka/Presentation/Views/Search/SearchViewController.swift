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
    private let disableEditingBehavior = DisableEditingTableViewDelegate()
	private var viewModel: SearchViewModel!
    private var navigationDelegate: SearchNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: SearchViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: SearchBarView!
    @IBOutlet private weak var emptyState: UIView!
    @IBOutlet private weak var noResults: UIView!
    
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
        self.viewModel.loadSearchHistory()
        self.tableView.rx_setDelegate(self.disableEditingBehavior)
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
	
    private func setupBinding() {
        self.searchBar.text.bindTo(self.viewModel.searchPhrase)
            .addDisposableTo(self.disposables)
        
        let searchIsEmptyObservable = self.searchBar.text.map { $0.isEmpty }
        
        let seachItemsObservable = Observable<[SearchResult]>.combineLatest(searchIsEmptyObservable, self.viewModel.searchResult, self.viewModel.searchHistory.asObservable()) { searchIsEmpty, searchResult, searchHistory in
            if searchIsEmpty {
                return searchHistory
            } else {
                return searchResult
            }
        }
        
        seachItemsObservable.bindTo(self.tableView.configurableCells(SearchResultCell.self))
            .addDisposableTo(self.disposables)
        
        Observable<Bool>.combineLatest(searchIsEmptyObservable, seachItemsObservable.map { $0.any() == false }) { $0 && $1 }
            .map { $0 == false }
            .bindTo(self.emptyState.rx_hidden)
            .addDisposableTo(self.disposables)
    }
    
    private func resigsterForEvents() {
        self.tableView.rx_modelSelected(SearchResult.self)
            .subscribeNext { [unowned self] searchResult in
                self.viewModel.saveSearch(searchResult)
                self.navigationDelegate.showBollards(searchResult)
            }.addDisposableTo(self.disposables)
    }
}
