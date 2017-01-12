//
//  TimeCell.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class TimeCell: UITableViewCell {
    @IBOutlet fileprivate weak var roundBackgroundView: UIView!
    @IBOutlet fileprivate weak var lineLabel: UILabel!
    @IBOutlet fileprivate weak var directionLabel: UILabel!
    @IBOutlet fileprivate weak var minutesLabel: UILabel!
    @IBOutlet fileprivate weak var departureTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundBackgroundView.layer.cornerRadius = 5
    }
    
}

extension TimeCell: NibLoadableView {

}

extension TimeCell: Configurable {
	func configure(_ model: Time) {
        self.lineLabel.text = model.line
        self.directionLabel.text = "➙ \(model.directionName)"
        self.minutesLabel.text = "\(model.minutes) min"
        let converter = DepartureTimeToStringConverter()
        self.departureTimeLabel.text = converter.convert(model.departure)
        
        if model.realTime {
            self.minutesLabel.textColor = UIColor(argbHex: 0xFF43BAEE)
        } else {
            self.minutesLabel.textColor = UIColor(color: .mainLight)
        }
        
        if model.minutes < 3 {
            self.minutesLabel.textColor = UIColor(argbHex: 0xFFFE3824)
        }
    }
}
