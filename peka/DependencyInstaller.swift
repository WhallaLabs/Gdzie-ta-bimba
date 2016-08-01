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
        self.registerNavigationControllers()
    }
    
    private class func registerServices() {
        defaultContainer.register(Executor.self) { _ in Executor() }
        defaultContainer.register(HttpHeadersProvider.self) { _ in PekaHttpHeadersProvider() }
        defaultContainer.register(FormBodyBuilder.self) { _ in FormUrlEncodedBuilder() }
    }
    
    private class func registerProviders() {
        defaultContainer.register(RestApiProvider.self) { r in
            ApiProvider(endpoint: ApiConfig.pekaEndpoint,
                        httpHeadersProvider: r.resolve(HttpHeadersProvider.self)!,
                        formBodyBuilder: r.resolve(FormBodyBuilder.self)!)
        }
        defaultContainer.register(RestApiProvider.self, name: stopPointsApiProvider) { r in
            ApiProvider(endpoint: ApiConfig.stopPointsEndpoint,
                        httpHeadersProvider: r.resolve(HttpHeadersProvider.self)!,
                        formBodyBuilder: r.resolve(FormBodyBuilder.self)!)
        }
        
        defaultContainer.registerPerContainerLifetime(StopPointPushpinsCache.self) { r in StopPointPushpinsCache() }

    }
    
    private class func registerViewControllers() {
        defaultContainer.registerForStoryboard(SearchViewController.self) { r, c in
            let navigationController = r.resolve(SearchNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(SearchViewModel.self)!
            c.installDependencies(viewModel, navigationController)
        }
        defaultContainer.registerForStoryboard(BollardsViewController.self) { r, c in
            let navigationController = r.resolve(BollardsNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(BollardsViewModel.self)!
            c.installDependencies(viewModel, navigationController)
        }
        defaultContainer.registerForStoryboard(LineBollardsViewController.self) { r, c in
            let navigationController = r.resolve(LineBollardsNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(LineBollardsViewModel.self)!
            c.installDependencies(viewModel, navigationController)
        }
    }
    
    private class func registerViewModels() {
        defaultContainer.register(SearchViewModel.self) { r in
            SearchViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(BollardsViewModel.self) { r in
            BollardsViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(LineBollardsViewModel.self) { r in
            LineBollardsViewModel(executor: r.resolve(Executor.self)!)
        }
    }
    
    private class func registerCommands() {
        
    }
    
    private class func registerQueries() {
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetStopPointPushpinsQuery)) { r in
            GetStopPointPushpinsQueryHandler(apiProvider: r.resolve(RestApiProvider.self, name: stopPointsApiProvider)!, stopPointsCache: r.resolve(StopPointPushpinsCache.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(SearchQuery)) { r in
            SearchQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardsByStopPointQuery)) { r in
            GetBollardsByStopPointQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardsByStreetQuery)) { r in
            GetBollardsByStreetQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardsByLineQuery)) { r in
            GetBollardsByLineQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
    }
    
    private class func registerNavigationControllers() {
        defaultContainer.register(SearchNavigationControllerDelegate.self) { (_, arg: SearchViewController) in
            SearchNavigationController(viewController: arg)
        }
        defaultContainer.register(BollardsNavigationControllerDelegate.self) { (_, arg: BollardsViewController) in
            BollardsNavigationController(viewController: arg)
        }
        defaultContainer.register(LineBollardsNavigationControllerDelegate.self) { (_, arg: LineBollardsViewController) in
            LineBollardsNavigationController(viewController: arg)
        }
    }
}