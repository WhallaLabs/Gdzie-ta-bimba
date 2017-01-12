//
//  LineBollardsViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class LineBollardsViewConfigurator: NSObject {

	@IBOutlet fileprivate weak var viewController: LineBollardsViewController!
    @IBOutlet fileprivate weak var tableView: UITableView!
    
	func configure() {
        self.tableView.register(BollardCell.self)
        self.tableView.register(DirectionHeader.self)
        self.viewController.navigationController?.setNavigationBarHidden(false, animated: true)
	}
}
