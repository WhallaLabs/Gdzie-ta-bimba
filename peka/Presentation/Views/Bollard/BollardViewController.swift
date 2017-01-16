//
//  BollardViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BollardViewController: UIViewController {

    fileprivate let disposables = DisposeBag()
    fileprivate let disableEditingBehavior = DisableEditingTableViewDelegate()
    fileprivate var viewModel: BollardViewModel!
    private var adsSettings: AdsSettings!
	fileprivate var navigationDelegate: BollardNavigationControllerDelegate!
    fileprivate let favoriteStateToImageConverter = FavoriteStateToImageConverter()

	@IBOutlet fileprivate weak var viewConfigurator: BollardViewConfigurator!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var toggleFavoriteButton: UIBarButtonItem!
    @IBOutlet fileprivate weak var messageBubble: MessageBubbleView!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var adHeightConstraint: NSLayoutConstraint!
    
	func installDependencies(_ viewModel: BollardViewModel, _ navigationDelegate: BollardNavigationControllerDelegate, _ adsSettings: AdsSettings) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
        self.adsSettings = adsSettings
	}
    
    func loadBollard(_ symbol: String) {
        self.viewModel.loadBollard(symbol).addDisposableTo(self.disposables)
    }
    
    func loadTimes(_ bollard: Bollard) {
        self.viewModel.loadTimesForBollard(bollard).addDisposableTo(self.disposables)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.tableView.rx.setDelegate(self.disableEditingBehavior).addDisposableTo(self.disposables)
        self.adBannerView.load(viewController: self)
        self.adsSettings.adsDisabledObservable.map(AddSettingsToBannerHeightConverter())
            .bindTo(self.adHeightConstraint.rx.constant)
            .addDisposableTo(self.disposables)
	}
	
    fileprivate func setupBinding() {
        self.viewModel.times.asObservable()
            .bindTo(self.tableView.configurableCells(TimeCell.self))
            .addDisposableTo(self.disposables)
        
        let bollardObservable = self.viewModel.bollard.asObservable().filterNil()
        
        bollardObservable.map(self.favoriteStateToImageConverter).subscribeNext { [unowned self] image in
            self.toggleFavoriteButton.image = image
        }.addDisposableTo(self.disposables)
        
        self.viewModel.message.asObservable()
            .bindTo(self.messageBubble.content)
            .addDisposableTo(self.disposables)
        
        self.viewModel.message.asObservable()
            .map(IsNilConverter())
            .map { $0 ? CGFloat(0) : CGFloat(36) }
            .subscribeNext { [unowned self] messageHeight in
                let inset = UIEdgeInsetsMake(0, 0, messageHeight, 0)
                self.tableView.contentInset = inset
                self.tableView.scrollIndicatorInsets = inset
            }.addDisposableTo(self.disposables)
    }
    
    @IBAction fileprivate func toggleFavorite() {
        self.viewModel.toggleFavorite()
    }
}
