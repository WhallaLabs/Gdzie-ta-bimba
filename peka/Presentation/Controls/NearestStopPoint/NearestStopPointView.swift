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
    
    @IBOutlet private weak var titleButton: UIButton!
    @IBOutlet private weak var linesLabel: UILabel!
    
    let stopPoint = Variable<StopPointPushpin?>(nil)
    
    var action: Observable<StopPointPushpin> {
        return self.titleButton.rx_tap.map { [unowned self] _ in self.stopPoint.value }.filterNil()
    }
    
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
        self.stopPoint.asObservable()
            .filterNil()
            .subscribeNext { [unowned self] stopPoint in
                self.titleButton.setTitle(stopPoint.name, forState: .Normal)
                self.linesLabel.text = stopPoint.headsigns
            }.addDisposableTo(self.disposables)
        
        self.stopPoint.asObservable()
            .map { $0 == nil }
            .bindTo(self.rx_hidden)
            .addDisposableTo(self.disposables)
    }
}

extension NearestStopPointView: NibLoadableView {
    
}
