//
//  MapViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MapViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: MapViewModel!

	@IBOutlet private weak var viewConfigurator: MapViewConfigurator!

	func installDependencies(viewModel: MapViewModel) {
		self.viewModel = viewModel
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
	}
	
}
