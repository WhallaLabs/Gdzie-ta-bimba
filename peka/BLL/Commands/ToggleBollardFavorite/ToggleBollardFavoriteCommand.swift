//
//  ToggleBollardFavoriteCommand.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class ToggleBollardFavoriteCommand: Command {
    let bollard: Bollard
    
    init(bollard: Bollard) {
        self.bollard = bollard
    }
}