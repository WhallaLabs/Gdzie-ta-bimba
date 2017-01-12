//
//  NearestStopPointView.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

@IBDesignable
final class NearestStopPointView: UIView {
    fileprivate let disposables = DisposeBag()
    fileprivate let tapRecognizer = UITapGestureRecognizer()
    fileprivate let routeTypeToImageConverter = RouteTypeToIconImageConverter()
    fileprivate let animationDuration: TimeInterval = 0.35
    
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var linesLabel: UILabel!
    @IBOutlet fileprivate weak var firstRouteType: UIImageView!
    @IBOutlet fileprivate weak var secondRouteType: UIImageView!
    
    let stopPoint = Variable<StopPointPushpin?>(nil)
    
    var animationDelay: TimeInterval = 0
    
    var action: Observable<StopPointPushpin> {
        return self.tapRecognizer.rx.event.map { [unowned self] _ in self.stopPoint.value }.filterNil()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupXib()
#if !TARGET_INTERFACE_BUILDER
        self.configure()
        self.setupBinding()
#endif
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupXib()
#if !TARGET_INTERFACE_BUILDER
        self.configure()
        self.setupBinding()
#endif
    }
    
    fileprivate func setupBinding() {
        self.stopPoint.asObservable()
            .filterNil()
            .subscribeNext { [unowned self] stopPoint in
                self.nameLabel.text = stopPoint.name
                self.linesLabel.text = stopPoint.headsigns
                self.configureRouteTypesIcons(stopPoint.routeTypes)
            }.addDisposableTo(self.disposables)
        
        self.stopPoint.asObservable()
            .map { $0 != nil }
            .subscribeNext { [unowned self] hasStopPoint in
                self.animateVisibility(hasStopPoint)
            }.addDisposableTo(self.disposables)
    }
    
    fileprivate func configure() {
        self.alpha = 0
        self.roundBackgroundView.addGestureRecognizer(self.tapRecognizer)
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    fileprivate func configureRouteTypesIcons(_ routeTypes: [RouteType]) {
        let imageViews = [self.firstRouteType, self.secondRouteType]
        imageViews.forEach { $0?.isHidden = true }
        let routeTypesEnumerate = routeTypes.distinct().take(2).enumerated()
        for (index, routeType) in routeTypesEnumerate {
            let imageView = imageViews[index]!
            imageView.isHidden = false
            imageView.image = self.routeTypeToImageConverter.convert(routeType)
        }
    }
    
    fileprivate func animateVisibility(_ visible: Bool) {
        UIView.animate(withDuration: self.animationDuration, delay: self.animationDelay, options: UIViewAnimationOptions(), animations: { 
            self.alpha = visible ? 1 : 0
        }, completion: nil)
    }
}

extension NearestStopPointView: NibLoadableView {
    
}
