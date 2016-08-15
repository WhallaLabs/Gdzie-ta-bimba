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
    
    private let pattern = "[\\s]{2,}"
    private let linkHtml = "<a href="
    
    func mapToObject(json: JSON) -> NSAttributedString? {
        guard let htmlContent = json["success"].array?.first?["content"].string,
            regex = try? NSRegularExpression(pattern: self.pattern, options: .CaseInsensitive) else {
                return nil
        }
        var content = htmlContent.stringByReplacingOccurrencesOfString(self.linkHtml, withString: " \(self.linkHtml)")
        content = regex.stringByReplacingMatchesInString(content,
                                                         options: .ReportProgress,
                                                         range: NSMakeRange(0, content.characters.count),
                                                         withTemplate: " ")
        
        guard let data = content.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        let options: [String : AnyObject] = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                                             NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding]
        let attributedString = try? NSAttributedString(data: data, options: options,  documentAttributes: nil)
        return attributedString
    }
}