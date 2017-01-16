//
//  RemoveAdsViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RemoveAdsViewController: UIViewController {

	private let disposables = DisposeBag()
    private var adsSettings: AdsSettings!
	private var viewModel: RemoveAdsViewModel!

	@IBOutlet private weak var viewConfigurator: RemoveAdsViewConfigurator!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var adHeightConstraint: NSLayoutConstraint!

	func installDependencies(_ viewModel: RemoveAdsViewModel, _ adsSettings: AdsSettings) {
		self.viewModel = viewModel
        self.adsSettings = adsSettings
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.updateTitle("Reklamy")
        self.adBannerView.load(viewController: self)
        self.adsSettings.adsDisabledObservable.map(AddSettingsToBannerHeightConverter())
            .bindTo(self.adHeightConstraint.rx.constant)
            .addDisposableTo(self.disposables)
	}
    
    @IBAction func removeAds() {
        self.viewModel.removeAds()
    }
    
    @IBAction func restoreTransactions() {
        self.viewModel.restoreTransactions()
    }
    
    @IBAction func restoreAds() {
        self.viewModel.restoreAds()
    }
}
