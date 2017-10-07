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
    
    func performSegue(_ identifier: SegueIdentifier) {
        self.performSegue(withIdentifier: identifier.rawValue, sender: nil)
    }
    
    func performSegue<T>(_ identifier: SegueIdentifier, parameter: T) {
        self.performSegue(withIdentifier: identifier.rawValue, sender: Box(parameter))
    }
    
    func segueIdentifierForSegue(_ segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier) else {
                fatalError("Invalid segue identifier \(String(describing: segue.identifier))")
        }
        
        return segueIdentifier
    }
}
