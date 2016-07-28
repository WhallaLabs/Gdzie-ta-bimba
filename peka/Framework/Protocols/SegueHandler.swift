//
//  SegueHandler.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

protocol SegueHandler {
    associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandler where Self: UIViewController, SegueIdentifier.RawValue == String {
    
    func performSegue(identifier: SegueIdentifier) {
        self.performSegueWithIdentifier(identifier.rawValue, sender: nil)
    }
    
    func performSegue<T>(identifier: SegueIdentifier, parameter: T) {
        self.performSegueWithIdentifier(identifier.rawValue, sender: Box(parameter))
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(segue.identifier)")
        }
        
        return segueIdentifier
    }
}