//
//  BollardsViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BollardsViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: BollardsViewModel!
	private var navigationDelegate: BollardsNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: BollardsViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    
	func installDependencies(viewModel: BollardsViewModel, _ navigationDelegate: BollardsNavigationControllerDelegate) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
	}
    
    func loadBollardsByStopPoint(stopPoint: StopPoint) {
        self.title = stopPoint.name
        self.viewModel.loadBollardsByStopPoint(stopPoint).addDisposableTo(self.disposables)
    }
    
    func loadBoolardsByStreet(name: String) {
        self.title = name
        self.viewModel.loadBollardsByStreet(name).addDisposableTo(self.disposables)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.registerForEvents()
        self.updateTitle(self.title!)
	}
	
    private func setupBinding() {
        self.viewModel.bollards.asObservable()
            .bindTo(self.tableView.configurableCells(GroupedDirectionsCell.self))
            .addDisposableTo(self.disposables)
    }
    
    private func registerForEvents() {
        self.tableView.rx_modelSelected(GroupedDirections.self)
            .map { $0.bollard }
            .subscribeNext { [unowned self] bollard in
                self.navigationDelegate.showBollard(bollard)
            }.addDisposableTo(self.disposables)
    }
}
