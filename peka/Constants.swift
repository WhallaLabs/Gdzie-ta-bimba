//
//  Constants.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation

struct Constants {
    static let appID = "1195530580"
    static let itunesURL = "https://itunes.apple.com/pl/app/id" + Constants.appID
    static let appstoreURL = "itms-apps://itunes.apple.com/app/id"  + Constants.appID
    
    struct AdMob {
        static let appId = "ca-app-pub-2344436403384102~3004188788"//"ca-app-pub-1891682170220364~5192892530"
        
    #if DEBUG
        static let bannerUnitId = "ca-app-pub-3940256099942544/2934735716"
    #else
        static let bannerUnitId = "ca-app-pub-2344436403384102/8051489570"//"ca-app-pub-1891682170220364/1572958132"
    #endif
    }
    
    struct InApp {
        static let removeAds = "remove_ads"
    }
}
