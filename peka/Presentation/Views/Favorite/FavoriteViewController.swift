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
    private var locationManager: LocationManager!

	@IBOutlet private weak var viewConfigurator: FavoriteViewConfigurator!

	func installDependencies(viewModel: FavoriteViewModel, _ locationManager: LocationManager!) {
		self.viewModel = viewModel
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
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
}
