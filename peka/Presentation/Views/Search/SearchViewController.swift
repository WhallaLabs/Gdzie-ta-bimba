//
//  SearchViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: SearchViewModel!

	@IBOutlet private weak var viewConfigurator: SearchViewConfigurator!

	func installDependencies(viewModel: SearchViewModel) {
		self.viewModel = viewModel
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
	}
	
}
