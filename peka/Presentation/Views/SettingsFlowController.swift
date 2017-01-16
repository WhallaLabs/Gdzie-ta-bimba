//
//  SettingsFlowController.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

final class SettingsFlowController: SettingsFlowControllerDelegate {
	private weak var viewController: SettingsViewController?

	init(viewController: SettingsViewController) {
		self.viewController = viewController
	}
	
}