//
//  FavoriteNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class FavoriteNavigationController: FavoriteNavigationControllerDelegate {
    private weak var viewController: FavoriteViewController?
    
    init(viewController: FavoriteViewController) {
        self.viewController = viewController
    }
    
    func showBollard(bollardSymbol: String) {
        let viewController: BollardViewController = UIStoryboard.instantiateInitialViewController()
        viewController.loadBollard(bollardSymbol)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}