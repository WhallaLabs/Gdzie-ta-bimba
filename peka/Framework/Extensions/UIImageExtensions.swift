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
    case Street = "street"
    case Pushpin = "pushpin"
    case favorite = "star-small"
    case gps = "location-arrow"
}

extension UIImage {
    convenience init(asset: ImageAssets) {
        self.init(named: asset.rawValue)!
    }
    
    convenience init(view: UIView) {
        let scale = UIScreen.main.scale
        view.contentScaleFactor = scale
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!, scale: scale, orientation: .up)
    }
    
    func imageWithColor(_ tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        tintColor.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0);
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
