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

	func configure() {
		self.configureTabBar()
	}
    
    private func configureTabBar() {
        let tabBar = self.viewController.tabBar
        tabBar.translucent = false
        tabBar.barTintColor = UIColor(color: .BackgroundLight)
        tabBar.tintColor = UIColor(argbHex: 0xFFB3C6D3)
        
        //TODO configure unselected color
    }
}