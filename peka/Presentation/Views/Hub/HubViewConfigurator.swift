//
//  HubViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class HubViewConfigurator: NSObject {

	@IBOutlet fileprivate weak var viewController: HubViewController!
    
    fileprivate let selectedColor = UIColor(argbHex: 0xFFB3C6D3).withAlphaComponent(0.6)
    fileprivate let unselectedColor = UIColor(argbHex: 0xFFB3C6D3)

	func configure() {
		self.configureTabBar()
	}
    
    fileprivate func configureTabBar() {
        let tabBar = self.viewController.tabBar
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(color: .backgroundLight)
        tabBar.tintColor = self.selectedColor
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : self.unselectedColor], for: UIControlState())
    }
    
    func configureTabBarItems() {
        guard let items = self.viewController.tabBar.items else {
            return
        }
        
        for item in items {
            item.image = item.image?.imageWithColor(self.unselectedColor).withRenderingMode(.alwaysOriginal)
        }
    }
}
