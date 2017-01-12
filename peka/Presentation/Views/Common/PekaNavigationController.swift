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
    
    fileprivate func configureNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = false
        self.view.backgroundColor = UIColor(color: .background)
        self.navigationBar.backgroundColor = UIColor.clear
        self.navigationBar.barTintColor = UIColor(color: .background)
    }
    
    fileprivate func configureColors() {
        self.navigationBar.tintColor = UIColor(color: .mainLight)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor(color: .mainLight)]
    }
}
