//
//  Constants.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation

struct Constants {
    static let appID = "324684580"
    static let itunesURL = "https://itunes.apple.com/pl/app/id" + Constants.appID
    static let appstoreURL = "itms-apps://itunes.apple.com/app/id"  + Constants.appID
    
#if DEBUG
    static let adBannerUnitId = "ca-app-pub-3940256099942544/2934735716"
#else
    static let adBannerUnitId = "ca-app-pub-1986565751919761/7766331939"
#endif
    
    static let removeAdsInAppId = "remove_ads"
}
