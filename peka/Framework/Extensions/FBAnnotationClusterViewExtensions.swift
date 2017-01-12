//
//  FBAnnotationClusterViewExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import MapKit

extension FBAnnotationClusterView {
    convenience init(annotation: FBAnnotationCluster) {
        let smallTemplate = FBAnnotationClusterTemplate(range: Range(uncheckedBounds: (lower: 0, upper: 6)), displayMode: .Image(imageName: "cluster-small"))
        let mediumTemplate = FBAnnotationClusterTemplate(range: Range(uncheckedBounds: (lower: 6, upper: 15)), displayMode: .Image(imageName: "cluster-medium"))
        let largeTemplate = FBAnnotationClusterTemplate(range: nil, displayMode: .Image(imageName: "cluster-large"))
        self.init(annotation: annotation, reuseIdentifier: FBAnnotationClusterView.identifier, configuration: FBAnnotationClusterViewConfiguration(templates: [smallTemplate, mediumTemplate], defaultTemplate: largeTemplate))
    }
}

extension MKAnnotationView: ReusableView {
    
}
