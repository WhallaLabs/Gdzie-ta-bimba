////
////  WidgetDependencyInstaller.swift
////  peka
////
////  Created by Wojciech Świerczyk on 09.02.2017.
////  Copyright © 2017 WhallaLabs. All rights reserved.
////
//import Foundation
//import Swinject
//import SwinjectStoryboard
//
//private let stopPointsApiProvider = "stopPointsApiProvider"
//
//extension SwinjectStoryboard {
//
//    class func setupWidget() {
//        self.registerServices()
//        self.registerProviders()
//        
//        defaultContainer.register(TodayViewModel.self) { r in
//            TodayViewModel(executor: r.resolve(Executor.self)!)
//        }
//        
//        defaultContainer.storyboardInitCompleted(TodayViewController.self) { r, c in
//            let viewModel = r.resolve(TodayViewModel.self)!
//            c.installDependencies(viewModel, r.resolve(LocationManager.self)!)
//        }
//        
//        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetNearestStopQuery.self)) { r in
//            GetNearestStopQueryHandler(stopPointsCache: r.resolve(StopPointPushpinsCache.self)!)
//        }
//    }
//
//    fileprivate class func registerServices() {
//        defaultContainer.register(Executor.self) { _ in Executor() }
//        defaultContainer.registerPerContainerLifetime(LocationManager.self) { _ in PekaLocationManager() }
//            .inObjectScope(.container)
//    }
//
//    fileprivate class func registerProviders() {
//        defaultContainer.register(RestApiProvider.self) { r in
//            ApiProvider(endpoint: ApiConfig.pekaEndpoint,
//                        httpHeadersProvider: r.resolve(HttpHeadersProvider.self)!,
//                        formBodyBuilder: r.resolve(FormBodyBuilder.self)!)
//        }
//        defaultContainer.register(RestApiProvider.self, name: stopPointsApiProvider) { r in
//            ApiProvider(endpoint: ApiConfig.stopPointsEndpoint,
//                        httpHeadersProvider: r.resolve(HttpHeadersProvider.self)!,
//                        formBodyBuilder: r.resolve(FormBodyBuilder.self)!)
//        }
//        
//        defaultContainer.registerPerContainerLifetime(StopPointPushpinsCache.self) { _ in StopPointPushpinsCache() }
//        
//    }
//
//    
//}
