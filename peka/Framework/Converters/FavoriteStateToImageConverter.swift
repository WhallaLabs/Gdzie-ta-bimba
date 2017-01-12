//
//  FavoriteStateToImageConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class FavoriteStateToImageConverter: Convertible {
    fileprivate let images = [true : UIImage(asset: .StarFull), false : UIImage(asset: .StarEmpty)]
    
    func convert(_ value: Bollard) -> UIImage {
        return self.images[value.isFavorite]!
    }
}
