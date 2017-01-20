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
    var inset: CGPoint = CGPoint(x: 15, y: 0)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.inset.x, dy: self.inset.y)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: self.inset.x, dy: self.inset.y)
    }
}
