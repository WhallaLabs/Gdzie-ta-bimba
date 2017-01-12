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

	fileprivate let disposables = DisposeBag()
    fileprivate let disableEditingBehavior = DisableEditingTableViewDelegate()
	fileprivate var viewModel: BollardsViewModel!
	fileprivate var navigationDelegate: BollardsNavigationControllerDelegate!

	@IBOutlet fileprivate weak var viewConfigurator: BollardsViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
	func installDependencies(_ viewModel: BollardsViewModel, _ navigationDelegate: BollardsNavigationControllerDelegate) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
	}
    
    func loadBollardsByStopPoint(_ stopPoint: StopPoint) {
        self.title = stopPoint.name
        self.viewModel.loadBollardsByStopPoint(stopPoint).addDisposableTo(self.disposables)
    }
    
    func loadBoolardsByStreet(_ name: String) {
        self.title = name
        self.viewModel.loadBollardsByStreet(name).addDisposableTo(self.disposables)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.registerForEvents()
        self.updateTitle(self.title!)
        self.tableView.rx.setDelegate(self.disableEditingBehavior).addDisposableTo(self.disposables)
	}
	
    fileprivate func setupBinding() {
        self.viewModel.bollards.asObservable()
            .map(GroupBollardDirectionsConverter())
            .bindTo(self.tableView.rx.items(cellIdentifier: GroupedDirectionsCell.identifier, cellType: GroupedDirectionsCell.self)) { [unowned self] _, model, cell in
                cell.delegate = self
                cell.configure(model)
            }.addDisposableTo(self.disposables)
    }
    
    fileprivate func registerForEvents() {
        self.tableView.rx.modelSelected(GroupedDirections.self)
            .map { $0.bollard }
            .subscribeNext { [unowned self] bollard in
                self.navigationDelegate.showBollard(bollard)
            }.addDisposableTo(self.disposables)
    }
}

extension BollardsViewController: GroupedDirectionsCellDelegate {
    func toggleFavorite(_ bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}
