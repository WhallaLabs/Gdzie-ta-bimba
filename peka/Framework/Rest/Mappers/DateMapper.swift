//
//  DateMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 03/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class DateMapper: ObjectMappable {
    
    private let format: String
    private static let dateFormatter = NSDateFormatter()
    
    init(format: String) {
        self.format = format
    }
    
    func mapToObject(json: JSON) -> NSDate? {
        guard let dateString = json.string else {
            return nil
        }
        DateMapper.dateFormatter.dateFormat = self.format
        return DateMapper.dateFormatter.dateFromString(dateString)
    }
}