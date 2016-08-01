//
//  UIStoryboardExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

extension UIStoryboard {
    class func instantiateInitialViewController<T: UIViewController>() -> T {
        let storyboardName = NSStringFromClass(T)
            .componentsSeparatedByString(".").last!
            .stringByReplacingOccurrencesOfString("ViewController", withString: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
}