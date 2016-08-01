//
//  SearchNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchNavigationController: SearchNavigationControllerDelegate {
    private weak var viewController: SearchViewController?
    
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
    
    func showBollards(searchResult: SearchResult) {
        if case .Line(let name) = searchResult {
            self.showBollardsByLine(name)
        } else {
            let bollardsViewContoller: BollardsViewController = UIStoryboard.instantiateInitialViewController()
            switch searchResult {
            case .Stop(let model):
                bollardsViewContoller.loadBollardsByStopPoint(model)
            case .Street(let name):
                bollardsViewContoller.loadBoolardsByStreet(name)
            default:
                fatalError()
            }
            self.viewController?.navigationController?.pushViewController(bollardsViewContoller, animated: true)
        }
    }
    
    private func showBollardsByLine(name: String) {
        let lineBollardsViewController: LineBollardsViewController = UIStoryboard.instantiateInitialViewController()
        lineBollardsViewController.loadBollards(name)
        self.viewController?.navigationController?.pushViewController(lineBollardsViewController, animated: true)
    }
}