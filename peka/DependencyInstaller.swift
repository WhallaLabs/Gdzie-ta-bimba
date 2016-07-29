//
//  DependencyInstaller.swift
//  kuchniaikropka
//
//  Created by Pawel Urbanowicz on 11.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import Swinject

private let stopPointsApiProvider = "stopPointsApiProvider"

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
        defaultContainer.register(HttpHeadersProvider.self) { _ in PekaHttpHeadersProvider() }
    }
    
    private class func registerProviders() {
        defaultContainer.register(RestApiProvider.self) { r in
            ApiProvider(endpoint: ApiConfig.pekaEndpoint, httpHeadersProvider: r.resolve(HttpHeadersProvider.self)!)
        }
        defaultContainer.register(RestApiProvider.self, name: stopPointsApiProvider) { r in
            ApiProvider(endpoint: ApiConfig.stopPointsEndpoint, httpHeadersProvider: r.resolve(HttpHeadersProvider.self)!)
        }

    }
    
    private class func registerViewControllers() {
        
    }
    
    private class func registerViewModels() {
        
    }
    
    private class func registerCommands() {
        
    }
    
    private class func registerQueries() {
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetStopPointPushpinsQuery)) { r in
            GetStopPointPushpinsQueryHandler(apiProvider: r.resolve(RestApiProvider.self, name: stopPointsApiProvider)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(SearchQuery)) { r in
            SearchQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
    }
}