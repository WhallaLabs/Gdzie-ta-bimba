//
//  XibLoader.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class XibLoader {
    private let xibName: String
    
    init(xibName: String) {
        self.xibName = xibName
    }
    
    func load(owner: UIView, autoresizingOptions: UIViewAutoresizing = [.FlexibleWidth, .FlexibleHeight]) -> UIView {
        let bundle = NSBundle(forClass: owner.dynamicType)
        let nib = UINib(nibName: self.xibName, bundle: bundle)
        let views = nib.instantiateWithOwner(owner, options: nil)
        let view = views.first as! UIView
        
        view.frame = owner.bounds
        view.autoresizingMask = autoresizingOptions
        
        return view
    }
    
    func load() -> UIView {
        let nib = UINib(nibName: self.xibName, bundle: nil)
        let views = nib.instantiateWithOwner(nil, options: nil)
        let view = views.first as! UIView
        
        return view
    }
}