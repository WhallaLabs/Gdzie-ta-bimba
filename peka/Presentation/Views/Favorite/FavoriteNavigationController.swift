//
//  FavoriteNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class FavoriteNavigationController: FavoriteNavigationControllerDelegate {
    fileprivate weak var viewController: FavoriteViewController?
    
    init(viewController: FavoriteViewController) {
        self.viewController = viewController
    }
    
    func showBollard(_ bollardSymbol: String, name: String) {
        let viewController: BollardViewController = UIStoryboard.instantiateInitialViewController()
        viewController.loadBollard(bollardSymbol)
        viewController.title = name
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
