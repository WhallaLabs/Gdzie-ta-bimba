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
        
        let timeZone = "GMT"
        DepartureTimeToStringConverter.dateFormatter.timeZone = NSTimeZone(name: timeZone)
    }
    
    func convert(value: NSDate) -> String {
        DepartureTimeToStringConverter.dateFormatter.dateFormat = self.format
        let dateString = DepartureTimeToStringConverter.dateFormatter.stringFromDate(value)
        return dateString
    }
}