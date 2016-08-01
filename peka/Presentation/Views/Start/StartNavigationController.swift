//
//  StartNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class StartNavigationController: StartNavigationControllerDelegate {
    private weak var viewController: StartViewController?
    
    init(viewController: StartViewController) {
        self.viewController = viewController
    }
    
    func showHub() {
        let hubViewController: HubViewController = UIStoryboard.instantiateInitialViewController()
        self.viewController?.navigationController?.pushViewController(hubViewController, animated: true)
    }
}