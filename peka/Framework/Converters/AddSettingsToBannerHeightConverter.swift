//
//  AddSettingsToBannerHeightConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

final class AddSettingsToBannerHeightConverter: Convertible {
    func convert(_ value: Bool) -> CGFloat {
        return value ? 0 : 50
    }
}
