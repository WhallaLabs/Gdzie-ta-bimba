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
    
    fileprivate let pattern = "[\\s]{2,}"
    fileprivate let linkHtml = "<a href="
    
    func mapToObject(_ json: JSON) -> NSAttributedString? {
        guard let htmlContent = json["success"].array?.first?["content"].string,
            let regex = try? NSRegularExpression(pattern: self.pattern, options: .caseInsensitive) else {
                return nil
        }
        var content = htmlContent.replacingOccurrences(of: self.linkHtml, with: " \(self.linkHtml)")
        content = regex.stringByReplacingMatches(in: content,
                                                 options: .reportProgress,
                                                 range: NSMakeRange(0, content.characters.count),
                                                 withTemplate: " ")
        
        guard let data = content.data(using: String.Encoding.utf8) else {
            return nil
        }
        let options: [String : AnyObject] = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType as AnyObject,
                                             NSCharacterEncodingDocumentAttribute : NSNumber(value: String.Encoding.utf8.rawValue)]
        let attributedString = try? NSAttributedString(data: data, options: options,  documentAttributes: nil)
        return attributedString
    }
}
