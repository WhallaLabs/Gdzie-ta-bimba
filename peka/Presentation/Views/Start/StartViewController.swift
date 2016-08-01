//
//  StartViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class StartViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: StartViewModel!
    private var navigationDelegate: StartNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: StartViewConfigurator!

	func installDependencies(viewModel: StartViewModel, navigationDelegate: StartNavigationControllerDelegate!) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        
        //TODO: update/download stoppoints
        self.navigationDelegate.showHub()
	}
}
