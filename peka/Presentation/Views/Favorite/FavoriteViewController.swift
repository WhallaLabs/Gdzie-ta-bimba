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
        self.locationManager.userLocation().subscribeNext { coordinates in
            print(coordinates)
        }.addDisposableTo(self.viewDisposables)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewDisposables = DisposeBag()
    }
    
    private func setupBinding() {
        self.viewModel.bollards.asObservable()
            .bindTo(self.tableView.configurableCells(BollardCell.self))
            .addDisposableTo(self.disposables)
    }
    
    private func registerForEvents() {
        self.tableView.rx_modelSelected(Bollard.self).subscribeNext { [unowned self] bollard in
            self.navigationDelegate.showBollard(bollard)
        }.addDisposableTo(self.disposables)
    }
}
