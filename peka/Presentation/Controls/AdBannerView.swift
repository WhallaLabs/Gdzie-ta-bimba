//
//  AdBannerCell.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Swinject
import SwinjectStoryboard

final class AdBannerView: GADBannerView {
    
    func load(viewController: UIViewController) {
        let settings = SwinjectStoryboard.defaultContainer.resolve(AdsSettings.self)!
        if settings.adsDisabled {
            return
        }
    #if DEBUG
        self.adUnitID = "ca-app-pub-3940256099942544/2934735716"
    #else
        self.adUnitID = "ca-app-pub-1986565751919761/7766331939"
    #endif
        self.rootViewController = viewController
        self.load(GADRequest())
    }
}
