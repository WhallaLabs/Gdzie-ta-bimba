//
//  TextFieldWithInset.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

@IBDesignable
final class TextFieldWithInset: UITextField {
    
    @IBInspectable
    var inset: CGPoint = CGPointMake(15, 0)
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, self.inset.x, self.inset.y)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, self.inset.x, self.inset.y)
    }
}