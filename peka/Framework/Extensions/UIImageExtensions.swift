//
//  UIImageExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

enum ImageAssets: String {
    case StarEmpty = "star-empty"
    case StarFull = "star-full"
    case PushpinEmpty = "pushpin-empty"
    case Bus = "bus"
    case Tram = "tram"
}

extension UIImage {
    convenience init(asset: ImageAssets) {
        self.init(named: asset.rawValue)!
    }
    
    convenience init(view: UIView) {
        let scale = UIScreen.mainScreen().scale
        view.contentScaleFactor = scale
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!, scale: scale, orientation: .Up)
    }
    
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        tintColor.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        let rect = CGRectMake(0, 0, self.size.width, self.size.height) as CGRect
        CGContextClipToMask(context, rect, self.CGImage)
        CGContextFillRect(context, rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}