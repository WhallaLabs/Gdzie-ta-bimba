//
//  NibLoadableView.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    func setupXib(_ autoresizingOptions: UIViewAutoresizing = [.flexibleWidth, .flexibleHeight]) {
        let view = XibLoader(xibName: Self.nibName).load(self, autoresizingOptions: autoresizingOptions)
        self.addSubview(view)
    }
}
