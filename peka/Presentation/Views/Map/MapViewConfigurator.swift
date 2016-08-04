//
//  MapViewConfigurator.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class MapViewConfigurator: NSObject {

	@IBOutlet private weak var viewController: MapViewController!

	func configure() {
        self.viewController.updateTitle("")
	}
}
