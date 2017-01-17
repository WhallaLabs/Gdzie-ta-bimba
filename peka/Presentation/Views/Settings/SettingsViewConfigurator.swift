//
//  SettingsViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

final class SettingsViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: SettingsViewController!
    @IBOutlet private weak var disableAdsButton: UIButton!
    @IBOutlet private weak var rateAppButton: UIButton!

	func configure() {
        self.disableAdsButton.layer.cornerRadius = 5
        self.rateAppButton.layer.cornerRadius = 5
        
        self.disableAdsButton.setTitle("Ads".localized, for: .normal)
        self.rateAppButton.setTitle("RateApp".localized, for: .normal)
	}
}
