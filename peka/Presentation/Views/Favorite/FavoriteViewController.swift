//
//  FavoriteViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let nearestStopPointDefaultHeight: CGFloat = 97
private let heightAnimationDuration: NSTimeInterval = 0.3

final class FavoriteViewController: UIViewController {

	private let disposables = DisposeBag()
    private var viewDisposables = DisposeBag()
    private let disableEditingBehavior = DisableEditingTableViewDelegate()
	private var viewModel: FavoriteViewModel!
    private var navigationDelegate: FavoriteNavigationControllerDelegate!
    private var locationManager: LocationManager!

	@IBOutlet private weak var viewConfigurator: FavoriteViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nearestStopPointView: NearestStopPointView!
    @IBOutlet private weak var nearestStopPointHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var emptyState: UIView!
    
	func installDependencies(viewModel: FavoriteViewModel, _ navigationDelegate: FavoriteNavigationControllerDelegate, _ locationManager: LocationManager!) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        self.nearestStopPointView.animationDelay = heightAnimationDuration
		self.viewConfigurator.configure()
        self.viewModel.loadFavouriteBollards().addDisposableTo(self.disposables)
        self.setupBinding()
        self.registerForEvents()
        self.tableView.rx_setDelegate(self.disableEditingBehavior)
	}
	
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.initializeNearestStopPoint(self.locationManager.userLocation()).addDisposableTo(self.viewDisposables)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewDisposables = DisposeBag()
    }
    
    private func setupBinding() {
        self.viewModel.bollards.asObservable()
            .bindTo(self.tableView.rx_itemsWithCellIdentifier(BollardCell.identifier, cellType: BollardCell.self)) { [unowned self] _, model, cell in
                cell.configure(model)
                cell.delegate = self
            }.addDisposableTo(self.disposables)
        
        self.viewModel.nearestStopPoint.asObservable()
            .bindTo(self.nearestStopPointView.stopPoint)
            .addDisposableTo(self.disposables)
        
        self.viewModel.nearestStopPoint.asObservable()
            .map {  $0 == nil ? 0 : nearestStopPointDefaultHeight }
            .subscribeNext { [unowned self] height in
                self.nearestStopPointHeightConstraint.constant = height
                UIView.animateWithDuration(heightAnimationDuration) {
                    self.view.layoutIfNeeded()
                }
            }.addDisposableTo(self.disposables)
        
        self.viewModel.bollards.asObservable()
            .map { $0.any() }
            .bindTo(self.emptyState.rx_hidden)
            .addDisposableTo(self.disposables)
    }
    
    private func registerForEvents() {
        let favoriteBollardObservable = self.tableView.rx_modelSelected(Bollard.self).map { ($0.symbol, $0.name) }
        let nearestStopAction = self.nearestStopPointView.action.map { ($0.id, $0.name) }
        
        Observable.of(favoriteBollardObservable, nearestStopAction)
            .merge()
            .subscribeNext { [unowned self] symbol, name in
                self.navigationDelegate.showBollard(symbol, name: name)
            }.addDisposableTo(self.disposables)
    }
}

extension FavoriteViewController: BollardCellDelegate {
    func toggleFavorite(bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}
