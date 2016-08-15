//
//  MessageMapper.swift
//  peka
//
//  Created by Tomasz Pikć on 15/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation
import SwiftyJSON

final class MessageMapper: ObjectMappable {
    
    func mapToObject(json: JSON) -> NSAttributedString? {
        guard let content = json["success"].array?.first?["content"].string,
            data = content.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        let options: [String : AnyObject] = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                                             NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding]
        let attributedString = try? NSAttributedString(data: data, options: options,  documentAttributes: nil)
        return attributedString
    }
}