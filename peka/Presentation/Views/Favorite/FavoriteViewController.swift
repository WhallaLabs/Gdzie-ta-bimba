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
    private var adsSettings: AdsSettings!
	fileprivate var viewModel: FavoriteViewModel!
    fileprivate var navigationDelegate: FavoriteNavigationControllerDelegate!
    fileprivate var locationManager: LocationManager!
    fileprivate let dataSource = RxTableViewSectionedAnimatedDataSource<FavoriteSection>()
    private let cellFactory = FavoriteCellFactory()

	@IBOutlet fileprivate weak var viewConfigurator: FavoriteViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var adHeightConstraint: NSLayoutConstraint!
    private var emptyStateFooterView: UIView?
    
	func installDependencies(_ viewModel: FavoriteViewModel, _ navigationDelegate: FavoriteNavigationControllerDelegate, _ locationManager: LocationManager, _ adsSettings: AdsSettings) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.locationManager = locationManager
        self.adsSettings = adsSettings
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyStateFooterView = self.tableView.tableFooterView
        self.cellFactory.delegate = self
		self.viewConfigurator.configure()
        self.viewModel.loadFavouriteBollards().addDisposableTo(self.disposables)
        self.setupBinding()
        self.registerForEvents()
        self.tableView.rx.setDelegate(self).addDisposableTo(self.disposables)
        self.adBannerView.load(viewController: self)
        self.adsSettings.adsDisabledObservable.map(AddSettingsToBannerHeightConverter())
            .bindTo(self.adHeightConstraint.rx.constant)
            .addDisposableTo(self.disposables)
        
        self.dataSource.canMoveRowAtIndexPath = { _, _ in return true }
        
        self.dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
            return indexPath.section != 0
        }
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
        self.dataSource.titleForHeaderInSection = { _, _ in return "x" }
        
        self.viewModel.bollards.asObservable()
            .map { $0.isNotEmpty }
            .distinctUntilChanged()
            .subscribeNext { [unowned self] (isTableNotEmpty) in
                if isTableNotEmpty {
                    self.tableView.tableFooterView = UIView()
                } else {
                    self.tableView.tableFooterView = self.emptyStateFooterView
                }
            }.addDisposableTo(self.disposables)
    }
    
    fileprivate func registerForEvents() {
        self.tableView.rx.modelSelected(StopPointIdentity.self).subscribeNext { [unowned self] (stopPoint) in
            self.navigationDelegate.showBollard(stopPoint.symbol, name: stopPoint.name)
        }.addDisposableTo(self.disposables)
    }
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        if self.tableView.isEditing {
            self.viewModel.saveOrder(sections: self.dataSource.sectionModels)
            self.tableView.setEditing(false, animated: true)
            sender.style = .plain
            sender.title = "Edit".localized
        } else {
            self.tableView.setEditing(true, animated: true)
            sender.style = .done
            sender.title = "Done".localized
        }
    }
    
    deinit {
        self.emptyStateFooterView = nil
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
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section == proposedDestinationIndexPath.section {
            return proposedDestinationIndexPath
        }
        return IndexPath(row: 0, section: sourceIndexPath.section)
    }
}
