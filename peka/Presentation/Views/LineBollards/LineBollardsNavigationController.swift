//
//  LineBollardsNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class LineBollardsNavigationController: LineBollardsNavigationControllerDelegate {
	private weak var viewController: LineBollardsViewController?

	init(viewController: LineBollardsViewController) {
		self.viewController = viewController
	}
	
    func showTimes(bollard: Bollard) {
        let viewController: BollardViewController = UIStoryboard.instantiateInitialViewController()
        viewController.loadTimes(bollard)
        viewController.title = bollard.name
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}