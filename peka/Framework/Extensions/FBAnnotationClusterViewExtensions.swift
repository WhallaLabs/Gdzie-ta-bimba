//
//  FBAnnotationClusterViewExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 06/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import MapKit
import FBAnnotationClusteringSwift

extension FBAnnotationClusterView {
    convenience init(annotation: FBAnnotationCluster) {
        self.init(annotation: annotation, reuseIdentifier: FBAnnotationClusterView.identifier, options: FBAnnotationClusterViewOptions(smallClusterImage: "cluster-small", mediumClusterImage: "cluster-medium", largeClusterImage: "cluster-large"))
    }
}

extension MKAnnotationView: ReusableView {
    
}