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
	private var viewModel: FavoriteViewModel!

	@IBOutlet private weak var viewConfigurator: FavoriteViewConfigurator!

	func installDependencies(viewModel: FavoriteViewModel) {
		self.viewModel = viewModel
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
	}
	
}
