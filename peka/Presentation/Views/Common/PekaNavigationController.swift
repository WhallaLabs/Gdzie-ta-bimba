//
//  PekaNavigationController.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class PekaNavigaitonController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
        self.configureColors()
    }
    
    private func configureNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.translucent = false
        self.view.backgroundColor = UIColor(color: .Background)
        self.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationBar.barTintColor = UIColor(color: .Background)
    }
    
    private func configureColors() {
        self.navigationBar.tintColor = UIColor(color: .MainLight)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(color: .MainLight)]
    }
}
