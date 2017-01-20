//
//  DepartureTimeToStringConverter.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

final class DepartureTimeToStringConverter: Convertible {
    fileprivate static let dateFormatter = DateFormatter()
    fileprivate let format: String
    
    init(format: String = "H:mm") {
        self.format = format
        
        let timeZone = "GMT"
        DepartureTimeToStringConverter.dateFormatter.timeZone = TimeZone(identifier: timeZone)
    }
    
    func convert(_ value: Date) -> String {
        DepartureTimeToStringConverter.dateFormatter.dateFormat = self.format
        let dateString = DepartureTimeToStringConverter.dateFormatter.string(from: value)
        return dateString
    }
}
