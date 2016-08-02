//
//  BollardsNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class BollardsNavigationController: BollardsNavigationControllerDelegate {
	private weak var viewController: BollardsViewController?

	init(viewController: BollardsViewController) {
		self.viewController = viewController
	}
    
    func showBollard(bollard: Bollard) {
        let viewController: BollardViewController = UIStoryboard.instantiateInitialViewController()
        viewController.loadTimes(bollard)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}