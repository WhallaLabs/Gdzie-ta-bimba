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
        let storyboardName = NSStringFromClass(T.self)
            .components(separatedBy: ".").last!
            .replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateInitialViewController() as! T
    }
}
