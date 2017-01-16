//
//  SettingsViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsViewController: UIViewController {

    private let disposables = DisposeBag()
    private var adsSettings: AdsSettings!
	private var flowController: SettingsFlowControllerDelegate!

	@IBOutlet private weak var viewConfigurator: SettingsViewConfigurator!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var adHeightConstraint: NSLayoutConstraint!

	func installDependencies(_ flowController: SettingsFlowControllerDelegate, _ adsSettings: AdsSettings) {
		self.flowController = flowController
        self.adsSettings = adsSettings
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.updateTitle("Więcej")
        self.adBannerView.load(viewController: self)
        self.adsSettings.adsDisabledObservable.map(AddSettingsToBannerHeightConverter())
            .bindTo(self.adHeightConstraint.rx.constant)
            .addDisposableTo(self.disposables)
        
        if let version = AppInfo.version {
            self.versionLabel.text = "wer. \(version)"
        }
	}
	
    @IBAction func disableAds() {
        self.flowController.showAdsSettings()
    }
    
    @IBAction func rateApp() {
        let url = URL(string: Constants.appstoreURL)!
        UIApplication.shared.openURL(url)
    }
}
