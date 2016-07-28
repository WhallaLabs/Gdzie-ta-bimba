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

	@IBOutlet private weak var viewConfigurator: HubViewConfigurator!

	func installDependencies(viewModel: HubViewModel) {
		self.viewModel = viewModel
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
	}
	
}
