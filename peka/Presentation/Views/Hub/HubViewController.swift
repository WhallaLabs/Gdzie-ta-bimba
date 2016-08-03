//
//  HubViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HubViewController: UITabBarController {

	private let disposables = DisposeBag()
	private var viewModel: HubViewModel!
    private var locationManager: LocationManager!

	@IBOutlet private weak var viewConfigurator: HubViewConfigurator!

	func installDependencies(viewModel: HubViewModel, _ locationManager: LocationManager) {
		self.viewModel = viewModel
        self.locationManager = locationManager
	}

    override func viewDidLoad() {
        self.locationManager.requestPermission()
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.viewModel.prepareStopPoints().addDisposableTo(self.disposables)
	}
	
}
