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
import RxDataSources

final class FavoriteViewController: UIViewController {

	fileprivate let disposables = DisposeBag()
    fileprivate var viewDisposables = DisposeBag()
	fileprivate var viewModel: FavoriteViewModel!
    fileprivate var navigationDelegate: FavoriteNavigationControllerDelegate!
    fileprivate var locationManager: LocationManager!
    fileprivate let dataSource = RxTableViewSectionedAnimatedDataSource<FavoriteSection>()
    private let cellFactory = FavoriteCellFactory()

	@IBOutlet fileprivate weak var viewConfigurator: FavoriteViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var emptyState: UIView!
    @IBOutlet private weak var adBannerView: AdBannerView!
    
	func installDependencies(_ viewModel: FavoriteViewModel, _ navigationDelegate: FavoriteNavigationControllerDelegate, _ locationManager: LocationManager!) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        self.cellFactory.delegate = self
		self.viewConfigurator.configure()
        self.viewModel.loadFavouriteBollards().addDisposableTo(self.disposables)
        self.setupBinding()
        self.registerForEvents()
        self.tableView.rx.setDelegate(self).addDisposableTo(self.disposables)
        self.adBannerView.load(viewController: self)
	}
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.initializeNearestStopPoints(self.locationManager.userLocation()).addDisposableTo(self.viewDisposables)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewDisposables = DisposeBag()
    }
    
    fileprivate func setupBinding() {
        self.viewModel.stopPoints.bindTo(self.tableView.rx.items(dataSource: self.dataSource)).addDisposableTo(self.disposables)
        self.dataSource.configureCell = self.cellFactory.create()
        self.dataSource.titleForHeaderInSection = { dataSource, index in return "x" }
        
        let anyStopPointsObservable = self.viewModel.bollards.asObservable()
            .map { $0.any() }
        anyStopPointsObservable.bindTo(self.emptyState.rx.isHidden)
            .addDisposableTo(self.disposables)
    }
    
    fileprivate func registerForEvents() {
        self.tableView.rx.modelSelected(StopPointIdentity.self).subscribeNext { [unowned self] (stopPoint) in
            self.navigationDelegate.showBollard(stopPoint.symbol, name: stopPoint.name)
        }.addDisposableTo(self.disposables)
    }
}

extension FavoriteViewController: BollardCellDelegate {
    func toggleFavorite(_ bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let model = self.dataSource.sectionModels[section]
        let view: ImageHeaderView = tableView.dequeueReusableHeaderFooter()
        view.configure(model)
        
        return view
    }
}
