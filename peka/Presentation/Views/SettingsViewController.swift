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
	private var viewModel: SettingsViewModel!
	private var flowController: SettingsFlowControllerDelegate!

	@IBOutlet private weak var viewConfigurator: SettingsViewConfigurator!
    @IBOutlet private weak var adBannerView: AdBannerView!
    @IBOutlet private weak var versionLabel: UILabel!

	func installDependencies(viewModel: SettingsViewModel, _ flowController: SettingsFlowControllerDelegate) {
		self.viewModel = viewModel
		self.flowController = flowController
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.updateTitle("Więcej")
        self.adBannerView.load(viewController: self)
        
        if let version = AppInfo.version {
            self.versionLabel.text = "wer. \(version)"
        }
	}
	
    @IBAction func disableAds() {
        
    }
    
    @IBAction func rateApp() {
        let url = URL(string: Constants.appstoreURL)!
        UIApplication.shared.openURL(url)
    }
}
