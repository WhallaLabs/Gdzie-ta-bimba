//
//  ReusableView.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol ReusableView {
    static var identifier: String { get }
}

extension ReusableView where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

extension UITableViewCell: ReusableView {
    
}

extension UICollectionReusableView: ReusableView {
    
}