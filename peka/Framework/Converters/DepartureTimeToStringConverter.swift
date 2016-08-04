//
//  DepartureTimeToStringConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class DepartureTimeToStringConverter: Convertible {
    private static let dateFormatter = NSDateFormatter()
    private let format: String
    
    init(format: String = "H:mm") {
        self.format = format
    }
    
    func convert(value: NSDate) -> String {
        DepartureTimeToStringConverter.dateFormatter.dateFormat = self.format
        return DepartureTimeToStringConverter.dateFormatter.stringFromDate(value)
    }
}