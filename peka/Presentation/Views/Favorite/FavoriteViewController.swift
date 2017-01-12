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
private let heightAnimationDuration: TimeInterval = 0.3

final class FavoriteViewController: UIViewController {

	fileprivate let disposables = DisposeBag()
    fileprivate var viewDisposables = DisposeBag()
    fileprivate let disableEditingBehavior = DisableEditingTableViewDelegate()
	fileprivate var viewModel: FavoriteViewModel!
    fileprivate var navigationDelegate: FavoriteNavigationControllerDelegate!
    fileprivate var locationManager: LocationManager!

	@IBOutlet fileprivate weak var viewConfigurator: FavoriteViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var nearestStopPointView: NearestStopPointView!
    @IBOutlet fileprivate weak var nearestStopPointHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var emptyState: UIView!
    
	func installDependencies(_ viewModel: FavoriteViewModel, _ navigationDelegate: FavoriteNavigationControllerDelegate, _ locationManager: LocationManager!) {
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
        self.tableView.rx.setDelegate(self.disableEditingBehavior).addDisposableTo(self.disposables)
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.initializeNearestStopPoint(self.locationManager.userLocation()).addDisposableTo(self.viewDisposables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewDisposables = DisposeBag()
    }
    
    fileprivate func setupBinding() {
        self.viewModel.bollards.asObservable()
            .bindTo(self.tableView.rx.items(cellIdentifier: BollardCell.identifier, cellType: BollardCell.self)) { [unowned self] _, model, cell in
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
                UIView.animate(withDuration: heightAnimationDuration) {
                    self.view.layoutIfNeeded()
                }
            }.addDisposableTo(self.disposables)
        
        self.viewModel.bollards.asObservable()
            .map { $0.any() }
            .bindTo(self.emptyState.rx.isHidden)
            .addDisposableTo(self.disposables)
    }
    
    fileprivate func registerForEvents() {
        let favoriteBollardObservable = self.tableView.rx.modelSelected(Bollard.self).map { ($0.symbol, $0.name) }
        let nearestStopAction = self.nearestStopPointView.action.map { ($0.id, $0.name) }
        
        Observable.of(favoriteBollardObservable, nearestStopAction)
            .merge()
            .subscribeNext { [unowned self] symbol, name in
                self.navigationDelegate.showBollard(symbol, name: name)
            }.addDisposableTo(self.disposables)
    }
}

extension FavoriteViewController: BollardCellDelegate {
    func toggleFavorite(_ bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}
