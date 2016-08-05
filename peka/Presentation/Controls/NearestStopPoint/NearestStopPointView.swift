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
    private let disposables = DisposeBag()
    private let tapRecognizer = UITapGestureRecognizer()
    private let routeTypeToImageConverter = RouteTypeToIconImageConverter()
    private let animationDuration: NSTimeInterval = 0.35
    
    @IBOutlet private weak var roundBackgroundView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var linesLabel: UILabel!
    @IBOutlet private weak var firstRouteType: UIImageView!
    @IBOutlet private weak var secondRouteType: UIImageView!
    
    let stopPoint = Variable<StopPointPushpin?>(nil)
    
    @IBInspectable
    var animationDelay: NSTimeInterval = 0
    
    var action: Observable<StopPointPushpin> {
        return self.tapRecognizer.rx_event.map { [unowned self] _ in self.stopPoint.value }.filterNil()
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
    
    private func setupBinding() {
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
    
    private func configure() {
        self.alpha = 0
        self.roundBackgroundView.addGestureRecognizer(self.tapRecognizer)
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
    private func configureRouteTypesIcons(routeTypes: [RouteType]) {
        let imageViews = [self.firstRouteType, self.secondRouteType]
        imageViews.forEach { $0.hidden = true }
        let routeTypesEnumerate = routeTypes.distinct().take(2).enumerate()
        for (index, routeType) in routeTypesEnumerate {
            let imageView = imageViews[index]
            imageView.hidden = false
            imageView.image = self.routeTypeToImageConverter.convert(routeType)
        }
    }
    
    private func animateVisibility(visible: Bool) {
        UIView.animateWithDuration(self.animationDuration, delay: self.animationDelay, options: .CurveEaseInOut, animations: { 
            self.alpha = visible ? 1 : 0
        }, completion: nil)
    }
}

extension NearestStopPointView: NibLoadableView {
    
}
