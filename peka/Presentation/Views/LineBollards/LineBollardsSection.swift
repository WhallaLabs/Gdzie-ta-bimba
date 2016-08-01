//
//  LineBollardsSection.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import RxDataSources

extension LineBollards: SectionModelType {
    var items: [Bollard] {
        return self.bollards
    }
    
    init(original: LineBollards, items: [Bollard]) {
        self.direction = original.direction
        self.bollards = items
    }
}