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
import PKHUD

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
        self.subscribeTransaction(observable: self.viewModel.removeAds())
    }
    
    @IBAction func restoreTransactions() {
        self.subscribeTransaction(observable: self.viewModel.restoreTransactions())
    }
    
    @IBAction func restoreAds() {
        self.viewModel.restoreAds()
    }
    
    private func subscribeTransaction(observable: Observable<Void>) {
        HUD.show(.progress)
        observable.subscribe(
            onNext: nil,
            onError: { (error) in
                HUD.hide()
            },
            onCompleted: { [unowned self] in
                HUD.hide()
                self.navigationController?.popViewController(animated: true)
            },
            onDisposed: nil).addDisposableTo(self.disposables)
    }
}
