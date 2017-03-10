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

    fileprivate let disposables = DisposeBag()
    private var adsSettings: AdsSettings!
	fileprivate var viewModel: LineBollardsViewModel!
	fileprivate var navigationDelegate: LineBollardsNavigationControllerDelegate!
    fileprivate let dataSource = RxTableViewSectionedReloadDataSource<LineBollards>()
    fileprivate var line: String!

	@IBOutlet fileprivate weak var viewConfigurator: LineBollardsViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var adHeightConstraint: NSLayoutConstraint!
    
	func installDependencies(_ viewModel: LineBollardsViewModel, _ navigationDelegate: LineBollardsNavigationControllerDelegate, _ adsSettings: AdsSettings) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.adsSettings = adsSettings
	}
    
    func loadBollards(_ line: String) {
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
        self.tableView.rx.setDelegate(self).addDisposableTo(self.disposables)
        self.adBannerView.load(viewController: self)
        self.adsSettings.adsDisabledObservable.map(AdsSettingsToBannerHeightConverter())
            .bindTo(self.adHeightConstraint.rx.constant)
            .addDisposableTo(self.disposables)
	}
	
    fileprivate func setupBinding() {
        self.viewModel.lineBollards.asObservable()
            .bindTo(self.tableView.rx.items(dataSource: self.dataSource))
            .addDisposableTo(self.disposables)
    }
    
    fileprivate func registerForEvents() {
        self.tableView.rx.modelSelected(Bollard.self).subscribeNext { [unowned self] bollard in
            self.navigationDelegate.showTimes(bollard)
        }.addDisposableTo(self.disposables)
    }
    
    fileprivate func configure() {
        self.dataSource.configureCell = { [unowned self] dataSource, tableView, indexPath, bollard in
            let cell: BollardCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(bollard)
            cell.delegate = self
            return cell
        }
    }
}

extension LineBollardsViewController: BollardCellDelegate {
    func toggleFavorite(_ bollard: Bollard) {
        self.viewModel.toggleFavorite(bollard)
    }
}

extension LineBollardsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: DirectionHeader = tableView.dequeueReusableHeaderFooter()
        let model = self.dataSource.sectionModels[section]
        view.configure(model.direction)
        return view
    }
}
