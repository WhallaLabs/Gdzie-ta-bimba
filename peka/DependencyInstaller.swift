//
//  DependencyInstaller.swift
//  kuchniaikropka
//
//  Created by Pawel Urbanowicz on 11.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import Swinject

extension SwinjectStoryboard {
    
    class func setup() {
        self.registerServices()
        self.registerProviders()
        self.registerViewControllers()
        self.registerViewModels()
        self.registerCommands()
        self.registerQueries()
    }
    
    private class func registerServices() {
        defaultContainer.register(Executor.self) { _ in Executor() }
    }
    
    private class func registerProviders() {
        
    }
    
    private class func registerViewControllers() {
        
    }
    
    private class func registerViewModels() {
        
    }
    
    private class func registerCommands() {
        
    }
    
    private class func registerQueries() {
        
    }
}