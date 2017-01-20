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

	fileprivate let disposables = DisposeBag()
	fileprivate var viewModel: HubViewModel!
    fileprivate var locationManager: LocationManager!

	@IBOutlet fileprivate weak var viewConfigurator: HubViewConfigurator!

	func installDependencies(_ viewModel: HubViewModel, _ locationManager: LocationManager) {
		self.viewModel = viewModel
        self.locationManager = locationManager
	}

    override func viewDidLoad() {
        self.locationManager.requestPermission()
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.viewModel.prepareStopPoints().addDisposableTo(self.disposables)
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewConfigurator.configureTabBarItems()
    }
	
}
