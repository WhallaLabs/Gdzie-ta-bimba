//
//  MapNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class MapNavigationController: MapNavigationControllerDelegate {
    fileprivate weak var viewController: MapViewController?
    
    init(viewController: MapViewController) {
        self.viewController = viewController
    }
    
    func showBollard(_ stopPointAnnotaion: StopPointAnnotation) {
        let viewController: BollardViewController = UIStoryboard.instantiateInitialViewController()
        viewController.loadBollard(stopPointAnnotaion.id)
        viewController.title = stopPointAnnotaion.title
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
