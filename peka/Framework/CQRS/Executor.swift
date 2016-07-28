//
//  Executor.swift
//  kuchniaikropka
//
//  Created by Pawel Urbanowicz on 11.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import Swinject

final class Executor {
    
    func execute<T: Command, TResult>(command: T) -> TResult {
        let handler = SwinjectStoryboard.defaultContainer.resolve(CommandHandler.self, name: NSStringFromClass(T.self))!
        return handler.handle(command) as! TResult
    }
    
    func execute<T: Command>(command: T) {
        let handler = SwinjectStoryboard.defaultContainer.resolve(CommandHandler.self, name: NSStringFromClass(T.self))!
        handler.handle(command)
    }
    
    func execute<T: Query, TResult>(query: T) -> TResult {
        let handler = SwinjectStoryboard.defaultContainer.resolve(QueryHandler.self, name: NSStringFromClass(T.self))!
        return handler.handle(query) as! TResult
    }
}