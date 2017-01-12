//
//  AttributedTextBuilder.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class AttributedTextBuilder {
    let attributedText: NSMutableAttributedString
    fileprivate let textRange: NSRange
    fileprivate var paragraphStyle: NSMutableParagraphStyle?
    
    init(string: String) {
        self.attributedText = NSMutableAttributedString(string: string)
        self.textRange = NSMakeRange(0, attributedText.length)
    }
    
    func setFont(_ font: UIFont, textRange: NSRange? = nil) -> AttributedTextBuilder {
        self.attributedText.addAttribute(NSFontAttributeName, value: font, range: textRange ?? self.textRange)
        return self
    }
    
    func setKern(_ value: CGFloat, textRange: NSRange? = nil) -> AttributedTextBuilder {
        self.attributedText.addAttribute(NSKernAttributeName, value: value, range: textRange ?? self.textRange)
        return self
    }
    
    func setLineHeight(_ value: CGFloat, textRange: NSRange? = nil) -> AttributedTextBuilder {
        if self.paragraphStyle == nil {
            self.paragraphStyle = NSMutableParagraphStyle()
        }
        self.paragraphStyle!.minimumLineHeight = value
        self.paragraphStyle!.maximumLineHeight = value
        self.attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle!, range: textRange ?? self.textRange)
        
        return self
    }
    
    func setColor(_ color: UIColor, textRange: NSRange? = nil) -> AttributedTextBuilder {
        self.attributedText.addAttribute(NSForegroundColorAttributeName, value: color, range: textRange ?? self.textRange)
        return self
    }
    
    func setAlignment(_ alignment: NSTextAlignment, textRange: NSRange? = nil) -> AttributedTextBuilder {
        if self.paragraphStyle == nil {
            self.paragraphStyle = NSMutableParagraphStyle()
        }
        paragraphStyle!.alignment = alignment
        
        self.attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle!, range: textRange ?? self.textRange)
        
        return self
    }
    
    func getAttributes() -> [String : AnyObject] {
        var range = self.textRange
        let attributes = self.attributedText.attributes(at: 0, effectiveRange: &range)
        return attributes as [String : AnyObject]
    }
}
