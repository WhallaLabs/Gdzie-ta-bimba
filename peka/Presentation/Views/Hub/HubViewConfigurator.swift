//
//  HubViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class HubViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: HubViewController!
    
    private let selectedColor = UIColor(argbHex: 0xFFB3C6D3).colorWithAlphaComponent(0.6)
    private let unselectedColor = UIColor(argbHex: 0xFFB3C6D3)

	func configure() {
		self.configureTabBar()
	}
    
    private func configureTabBar() {
        let tabBar = self.viewController.tabBar
        tabBar.translucent = false
        tabBar.barTintColor = UIColor(color: .BackgroundLight)
        tabBar.tintColor = self.selectedColor
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : self.unselectedColor], forState: .Normal)
    }
    
    func configureTabBarItems() {
        guard let items = self.viewController.tabBar.items else {
            return
        }
        
        for item in items {
            item.image = item.image?.imageWithColor(self.unselectedColor).imageWithRenderingMode(.AlwaysOriginal)
        }
    }
}