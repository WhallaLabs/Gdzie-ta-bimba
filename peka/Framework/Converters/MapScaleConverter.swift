//
//  MapScaleConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import MapKit

final class MapScaleConverter: Convertible {
    private let mapView: MKMapView
    
    init(mapView: MKMapView) {
        self.mapView = mapView
    }
    
    func convert(_: Any) -> Double {
        let mapBoundsWidth = Double(self.mapView.bounds.size.width)
        let mapRectWidth: Double = self.mapView.visibleMapRect.size.width
        let scale: Double = mapBoundsWidth / mapRectWidth
        
        return scale
    }
}