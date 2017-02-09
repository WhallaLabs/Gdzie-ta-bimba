//
//  SaveOrderCommand.swift
//  peka
//
//  Created by Tomasz Pikć on 20/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import Foundation

final class SaveOrderCommand: Command {
    let bollards: [Bollard]
    
    init(bollards: [Bollard]) {
        self.bollards = bollards
    }
}
