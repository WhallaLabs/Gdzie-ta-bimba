//
//  LineBollardsViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class LineBollardsViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: LineBollardsViewModel!
	private var navigationDelegate: LineBollardsNavigationControllerDelegate!
    private let dataSource = RxTableViewSectionedReloadDataSource<LineBollards>()
    private var line: String!

	@IBOutlet private weak var viewConfigurator: LineBollardsViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    
	func installDependencies(viewModel: LineBollardsViewModel, _ navigationDelegate: LineBollardsNavigationControllerDelegate) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
	}
    
    func loadBollards(line: String) {
        self.line = line
        self.viewModel.loadBollards(line).addDisposableTo(self.disposables)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.configure()
        self.registerForEvents()
        self.updateTitle(self.line)
	}
	
    private func setupBinding() {
        self.viewModel.lineBollards.asObservable()
            .bindTo(self.tableView.rx_itemsWithDataSource(self.dataSource))
            .addDisposableTo(self.disposables)
    }
    
    private func registerForEvents() {
        self.tableView.rx_modelSelected(Bollard.self).subscribeNext { [unowned self] bollard in
            self.navigationDelegate.showTimes(bollard)
        }.addDisposableTo(self.disposables)
    }
    
    private func configure() {
        self.dataSource.configureCell = { [unowned self] dataSource, tableView, indexPath, bollard in
            let cell: BollardCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(bollard)
            cell.delegate = self
            return cell
        }
        
        self.dataSource.titleForHeaderInSection = { dataSource, index in
            let model = dataSource.sectionAtIndex(index)
            return model.direction.description
        }
    }
}

extension LineBollardsViewController: BollardCellDelegate {
    func toggleFavorite(bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}
