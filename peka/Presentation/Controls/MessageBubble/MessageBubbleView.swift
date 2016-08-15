//
//  MessageBubbleCell.swift
//  peka
//
//  Created by Tomasz Pikć on 15/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@IBDesignable
final class MessageBubbleView: UIView {
    private let disposables = DisposeBag()
    
    let content: Variable<NSAttributedString?> = Variable(nil)

    @IBOutlet private weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet private weak var label: UILabel!
    
	required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
#if !TARGET_INTERFACE_BUILDER
        self.setupBinding()
#endif
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
#if !TARGET_INTERFACE_BUILDER
        self.setupBinding()
#endif
    }
    
    private func setupBinding() {
        self.content.asObservable()
            .filterNil()
            .subscribeNext { [unowned self] content in
                self.updateMessage(content)
            }.addDisposableTo(self.disposables)
        
        self.content.asObservable()
            .map(IsNilConverter())
            .bindTo(self.rx_hidden)
            .addDisposableTo(self.disposables)
    }
    
    private func updateMessage(attributedString: NSAttributedString) {
        let range = NSMakeRange(0, attributedString.length)
        let mutableString = NSMutableAttributedString(attributedString: attributedString)
        let attributes: [String : AnyObject] = [NSForegroundColorAttributeName : UIColor(color: .MainLight),
                                                NSFontAttributeName : UIFont.systemFontOfSize(16, weight: UIFontWeightBold)]
        mutableString.addAttributes(attributes, range: range)
        
        self.label.attributedText = mutableString
        self.beginAnimation()
    }
    
    private func beginAnimation() {
        self.layer.removeAllAnimations()
        self.label.layer.removeAllAnimations()
        
        self.label.sizeToFit()
        
        let width = CGRectGetWidth(self.frame)
        let animateTo = -CGRectGetWidth(self.label.frame)
        
        let labelWidth = CGRectGetWidth(self.label.frame)
        guard labelWidth > width else {
            self.leftConstraint.constant = 0
            self.setNeedsLayout()
            return
        }
        
        self.leftConstraint.constant = width
        self.layoutIfNeeded()
        self.leftConstraint.constant = animateTo
        
        let onePixelAnimationDuration: CGFloat = 0.007
        let duration = NSTimeInterval(onePixelAnimationDuration * labelWidth)
        
        UIView.animateWithDuration(duration,
                                   delay: 0,
                                   options: [.TransitionNone, .Repeat, .CurveLinear],
                                   animations: {
                                    self.layoutIfNeeded()
            }, completion: nil)
    }
}

extension MessageBubbleView: NibLoadableView {

}