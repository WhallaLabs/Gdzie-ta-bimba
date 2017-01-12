//
//  CommandHandler.swift
//  kuchniaikropka
//
//  Created by Pawel Urbanowicz on 11.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation

protocol CommandHandler {
    func handle(_ command: Command) -> Any
}
