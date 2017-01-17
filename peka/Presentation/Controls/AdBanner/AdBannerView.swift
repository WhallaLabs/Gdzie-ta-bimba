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
        self.adUnitID = Constants.AdMob.bannerUnitId
        self.rootViewController = viewController
        self.load(GADRequest())
    }
}
