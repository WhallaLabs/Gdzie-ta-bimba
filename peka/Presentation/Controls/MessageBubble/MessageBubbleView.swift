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
import TTTAttributedLabel

@IBDesignable
final class MessageBubbleView: UIView {
    fileprivate let disposables = DisposeBag()
    fileprivate let layoutSubviewsSubject = PublishSubject<Void>()
    
    let content: Variable<NSAttributedString?> = Variable(nil)

    @IBOutlet fileprivate weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var label: TTTAttributedLabel!
    
	required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
        self.configureLabel()
#if !TARGET_INTERFACE_BUILDER
        self.setupBinding()
#endif
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
        self.configureLabel()
#if !TARGET_INTERFACE_BUILDER
        self.setupBinding()
#endif
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutSubviewsSubject.onNext()
    }
    
    fileprivate func setupBinding() {
        
        let contentObservable = self.content.asObservable()

        contentObservable.map(IsNilConverter())
            .bindTo(self.rx.isHidden)
            .addDisposableTo(self.disposables)
        
        let resumeObservable = self.layoutSubviewsSubject.asObservable()
            .skip(1)
            .flatMap { [unowned self] in self.content.asObservable() }
        
        Observable.of(resumeObservable, contentObservable)
            .merge()
            .filterNil()
            .subscribeNext { [unowned self] content in
                self.updateMessage(content)
            }.addDisposableTo(self.disposables)
    }
    
    fileprivate func configureLabel() {
        self.label.delegate = self
        self.label.isUserInteractionEnabled = true
        self.label.enabledTextCheckingTypes = NSTextCheckingAllTypes
        self.label.linkAttributes = [kCTUnderlineStyleAttributeName as AnyHashable : NSNumber(value: 0)]
    }
    
    fileprivate func updateMessage(_ attributedString: NSAttributedString) {
        let range = NSMakeRange(0, attributedString.length)
        let mutableString = NSMutableAttributedString(attributedString: attributedString)
        let attributes: [String : AnyObject] = [NSForegroundColorAttributeName : UIColor(color: .mainLight),
                                                NSFontAttributeName : UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)]
        mutableString.addAttributes(attributes, range: range)
        
        self.label.setText(mutableString)
        self.beginAnimation()
    }
    
    fileprivate func beginAnimation() {
        self.layer.removeAllAnimations()
        self.label.layer.removeAllAnimations()
        
        self.label.sizeToFit()
        
        let width = self.frame.width
        let animateTo = -(self.label.frame).width
        
        let labelWidth = (self.label.frame).width
        guard labelWidth > width else {
            self.leftConstraint.constant = 0
            self.setNeedsLayout()
            return
        }
        
        self.leftConstraint.constant = width
        self.layoutIfNeeded()
        self.leftConstraint.constant = animateTo
        
        let onePixelAnimationDuration: CGFloat = 0.007
        let duration = TimeInterval(onePixelAnimationDuration * labelWidth)
        
        UIView.animate(withDuration: duration,
                                   delay: 0,
                                   options: [.repeat, .curveLinear],
                                   animations: {
                                    self.layoutIfNeeded()
            },
                                   completion: { _ in
                                    self.leftConstraint.constant = 0
                                    self.setNeedsLayout()
        })
    }
}

extension MessageBubbleView: NibLoadableView {

}

extension MessageBubbleView: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        print(url)
    }
}
