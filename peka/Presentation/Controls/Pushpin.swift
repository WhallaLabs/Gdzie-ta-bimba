//
//  Pushpin.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import MapKit

final class Pushpin: MKAnnotationView {
    init(pushpinAnnotation: StopPointAnnotation) {
        super.init(annotation: pushpinAnnotation, reuseIdentifier: Pushpin.identifier)
        
        self.image = UIImage(asset: .Pushpin)
        self.canShowCallout = true
        self.layer.anchorPoint = CGPoint(x: 0.5, y: 644.0 / 676.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
