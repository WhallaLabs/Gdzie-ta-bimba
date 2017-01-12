//
//  SearchNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchNavigationController: SearchNavigationControllerDelegate {
    fileprivate weak var viewController: SearchViewController?
    
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func showBollards(_ searchResult: SearchResult) {
        if case .line(let name) = searchResult {
            self.showBollardsByLine(name)
        } else {
            let bollardsViewContoller: BollardsViewController = UIStoryboard.instantiateInitialViewController()
            switch searchResult {
            case .stop(let model):
                bollardsViewContoller.loadBollardsByStopPoint(model)
            case .street(let name):
                bollardsViewContoller.loadBoolardsByStreet(name)
            default:
                fatalError()
            }
            self.viewController?.navigationController?.pushViewController(bollardsViewContoller, animated: true)
        }
    }
    
    fileprivate func showBollardsByLine(_ name: String) {
        let lineBollardsViewController: LineBollardsViewController = UIStoryboard.instantiateInitialViewController()
        lineBollardsViewController.loadBollards(name)
        self.viewController?.navigationController?.pushViewController(lineBollardsViewController, animated: true)
    }
}
