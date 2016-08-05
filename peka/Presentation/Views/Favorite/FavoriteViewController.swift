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

final class FavoriteViewController: UIViewController {

	private let disposables = DisposeBag()
    private var viewDisposables = DisposeBag()
	private var viewModel: FavoriteViewModel!
    private var navigationDelegate: FavoriteNavigationControllerDelegate!
    private var locationManager: LocationManager!

	@IBOutlet private weak var viewConfigurator: FavoriteViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nearestStopPointView: NearestStopPointView!
    
	func installDependencies(viewModel: FavoriteViewModel, _ navigationDelegate: FavoriteNavigationControllerDelegate, _ locationManager: LocationManager!) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.viewModel.loadFavouriteBollards().addDisposableTo(self.disposables)
        self.setupBinding()
        self.registerForEvents()
	}
	
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.locationManager.userLocation()
            .throttle(1, scheduler: MainScheduler.instance)
            .flatMap { [unowned self] coordinates in self.viewModel.nearesStop(coordinates) }
            .distinctUntilChanged()
            .map { $0 as StopPointPushpin? }
            .bindTo(self.nearestStopPointView.stopPoint)
            .addDisposableTo(self.viewDisposables)
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
    }
    
    private func registerForEvents() {
        let favoriteBollardObservable = self.tableView.rx_modelSelected(Bollard.self).map { $0.symbol }
        let nearestStopAction = self.nearestStopPointView.action.map { $0.id }
        
        Observable.of(favoriteBollardObservable, nearestStopAction)
            .merge()
            .subscribeNext { [unowned self] symbol in
                self.navigationDelegate.showBollard(symbol)
            }.addDisposableTo(self.disposables)
    }
}

extension FavoriteViewController: BollardCellDelegate {
    func toggleFavorite(bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}
