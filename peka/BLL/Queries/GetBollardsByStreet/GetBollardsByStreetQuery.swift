//
//  GetBollardsByStreetQuery.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//


import Foundation

final class GetBollardsByStreetQuery: Query {
    
    let street: String
    
    init(street: String) {
    	self.street = street
    }
}