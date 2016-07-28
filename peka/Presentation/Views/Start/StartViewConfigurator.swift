//
//  StartViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class StartViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: StartViewController!

	func configure() {
		self.viewController.navigationController?.setNavigationBarHidden(true, animated: false)
	}
}
