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
    
    fileprivate let format: String
    fileprivate static let dateFormatter = DateFormatter()
    
    init(format: String) {
        self.format = format
    }
    
    func mapToObject(_ json: JSON) -> Date? {
        guard let dateString = json.string else {
            return nil
        }
        DateMapper.dateFormatter.dateFormat = self.format
        let date = DateMapper.dateFormatter.date(from: dateString)
        return date
    }
}
