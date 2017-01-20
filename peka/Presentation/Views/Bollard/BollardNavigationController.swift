//
//  BollardNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class BollardNavigationController: BollardNavigationControllerDelegate {
	fileprivate weak var viewController: BollardViewController?

	init(viewController: BollardViewController) {
		self.viewController = viewController
	}
	
}
