//
//  WidgetCell.swift
//  peka
//
//  Created by Wojciech Świerczyk on 10.02.2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit

final class WidgetCell: UITableViewCell {
    @IBOutlet fileprivate weak var lineLabel: UILabel!
    @IBOutlet fileprivate weak var directionLabel: UILabel!
    @IBOutlet fileprivate weak var minutesLabel: UILabel!
    @IBOutlet fileprivate weak var departureTimeLabel: UILabel!
}

extension WidgetCell: NibLoadableView {

}

extension WidgetCell: Configurable {
    func configure(_ model: Time) {
        self.lineLabel.text = model.line
        self.directionLabel.text = "➙ \(model.directionName)"
        self.minutesLabel.text = "\(model.minutes) \("MinuteShortcut".localized)"
        let converter = DepartureTimeToStringConverter()
        self.departureTimeLabel.text = converter.convert(model.departure)
    
        if model.minutes < 3 {
            self.minutesLabel.textColor = UIColor(argbHex: 0xFFFE3824)
        }
    }
}
