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

    fileprivate let disposables = DisposeBag()
    fileprivate let disableEditingBehavior = DisableEditingTableViewDelegate()
	fileprivate var viewModel: SearchViewModel!
    fileprivate var navigationDelegate: SearchNavigationControllerDelegate!
    private var adsSettings: AdsSettings!

	@IBOutlet fileprivate weak var viewConfigurator: SearchViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: SearchBarView!
    @IBOutlet fileprivate weak var emptyState: UIView!
    @IBOutlet fileprivate weak var noResults: UIView!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var adHeightConstraint: NSLayoutConstraint!
    
	func installDependencies(_ viewModel: SearchViewModel, _ navigationDelegate: SearchNavigationControllerDelegate, _ adsSettings: AdsSettings) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.adsSettings = adsSettings
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.viewModel.initializeSearch().addDisposableTo(self.disposables)
        self.resigsterForEvents()
        self.viewModel.loadSearchHistory().addDisposableTo(self.disposables)
        self.tableView.rx.setDelegate(self.disableEditingBehavior).addDisposableTo(self.disposables)
        self.adBannerView.load(viewController: self)
        self.adsSettings.adsDisabledObservable.map(AddSettingsToBannerHeightConverter())
            .bindTo(self.adHeightConstraint.rx.constant)
            .addDisposableTo(self.disposables)
        
        self.viewModel.noResults.map { $0 == false }
            .bindTo(self.noResults.rx.isHidden)
            .addDisposableTo(self.disposables)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
	
    private func setupBinding() {
        self.searchBar.text.bindTo(self.viewModel.searchPhrase)
            .addDisposableTo(self.disposables)
        
        let searchIsEmptyObservable = self.viewModel.searchPhrase.asObservable().map { $0.isEmpty }
        
        let seachItemsObservable = Observable<[SearchResult]>.combineLatest(searchIsEmptyObservable, self.viewModel.searchResult, self.viewModel.searchHistory.asObservable()) { searchIsEmpty, searchResult, searchHistory in
            if searchIsEmpty {
                return searchHistory
            } else {
                return searchResult
            }
        }
        
        seachItemsObservable.bindTo(self.tableView.configurableCells(SearchResultCell.self))
            .addDisposableTo(self.disposables)
        
        Observable<Bool>.combineLatest(searchIsEmptyObservable, seachItemsObservable.map { $0.isEmpty }) { $0 && $1 }
            .map { $0 == false }
            .bindTo(self.emptyState.rx.isHidden)
            .addDisposableTo(self.disposables)
    }
    
    private func resigsterForEvents() {
        self.tableView.rx.modelSelected(SearchResult.self)
            .subscribeNext { [unowned self] searchResult in
                self.viewModel.saveSearch(searchResult)
                self.navigationDelegate.showBollards(searchResult)
            }.addDisposableTo(self.disposables)
    }
}
