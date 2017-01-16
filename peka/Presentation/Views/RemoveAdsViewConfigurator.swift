//
//  RemoveAdsViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

final class RemoveAdsViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: RemoveAdsViewController!
    @IBOutlet private weak var removeAdsButton: UIButton!
    @IBOutlet private weak var restoreTransactionsButton: UIButton!
    @IBOutlet private weak var restoreAdsButton: UIButton!
    
	func configure() {
        self.removeAdsButton.layer.cornerRadius = 5
        self.restoreTransactionsButton.layer.cornerRadius = 5
        self.restoreAdsButton.layer.cornerRadius = 5
	}
}
