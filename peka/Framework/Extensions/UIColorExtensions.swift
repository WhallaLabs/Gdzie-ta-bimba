//
//  UIColorExtensions.swift
//  Antidate
//
//  Created by WhallaLabs on 11.03.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

enum AppColors: UInt64 {
    case background = 0xFF0D2540
    case backgroundLight = 0xFF275482
    case mainLight = 0xFFB3C6D3
}

extension UIColor {
    convenience init(color: AppColors) {
        self.init(argbHex: color.rawValue)
    }
    
    convenience init(argbHex: UInt64) {
        let components = (
            A: CGFloat((argbHex >> 24) & 0xff) / 255,
            R: CGFloat((argbHex >> 16) & 0xff) / 255,
            G: CGFloat((argbHex >> 08) & 0xff) / 255,
            B: CGFloat((argbHex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: components.A)
    }
}

