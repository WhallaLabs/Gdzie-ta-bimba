//
//  DependencyInstaller.swift
//  kuchniaikropka
//
//  Created by Pawel Urbanowicz on 11.05.2016.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

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
    
    fileprivate class func registerServices() {
        defaultContainer.register(Executor.self) { _ in Executor() }
        defaultContainer.register(HttpHeadersProvider.self) { _ in PekaHttpHeadersProvider() }
        defaultContainer.register(FormBodyBuilder.self) { _ in FormUrlEncodedBuilder() }
        defaultContainer.registerPerContainerLifetime(LocationManager.self) { _ in PekaLocationManager() }
        
        defaultContainer.register(AdsSettings.self) { _ in AdsSettings() }
            .inObjectScope(.container)
    }
    
    fileprivate class func registerProviders() {
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
        
        defaultContainer.registerPerContainerLifetime(StopPointPushpinsCache.self) { _ in StopPointPushpinsCache() }
        defaultContainer.register(FavoriteBollardsRepository.self) { _ in RealmFavoriteBollardsRepository() }
        defaultContainer.register(RecentSearchRepository.self) { _ in RealmRecentSearchRepository() }
        defaultContainer.register(FavoriteGroupedDirectionsComparator.self) { r in
            FavoriteGroupedDirectionsComparator(favouriteBollardsRepository: r.resolve(FavoriteBollardsRepository.self)!)
        }
        defaultContainer.register(FavoriteLineBollardComparator.self) { r in
            FavoriteLineBollardComparator(favoriteBollardsRepository: r.resolve(FavoriteBollardsRepository.self)!)
        }
        defaultContainer.register(FavoriteBollardComparator.self) { r in
            FavoriteBollardComparator(favoriteBollardsRepository: r.resolve(FavoriteBollardsRepository.self)!)
        }
    }
    
    fileprivate class func registerViewControllers() {
        defaultContainer.storyboardInitCompleted(HubViewController.self) { r, c in
            c.installDependencies(r.resolve(HubViewModel.self)!, r.resolve(LocationManager.self)!)
        }
        defaultContainer.storyboardInitCompleted(SearchViewController.self) { r, c in
            let navigationController = r.resolve(SearchNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(SearchViewModel.self)!
            c.installDependencies(viewModel, navigationController, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(BollardsViewController.self) { r, c in
            let navigationController = r.resolve(BollardsNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(BollardsViewModel.self)!
            c.installDependencies(viewModel, navigationController, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(LineBollardsViewController.self) { r, c in
            let navigationController = r.resolve(LineBollardsNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(LineBollardsViewModel.self)!
            c.installDependencies(viewModel, navigationController, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(BollardViewController.self) { r, c in
            let navigationController = r.resolve(BollardNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(BollardViewModel.self)!
            c.installDependencies(viewModel, navigationController, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(MapViewController.self) { r, c in
            let navigationController = r.resolve(MapNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(MapViewModel.self)!
            let locationManager = r.resolve(LocationManager.self)!
            c.installDependencies(viewModel, navigationController, locationManager, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(FavoriteViewController.self) { r, c in
            let navigationController = r.resolve(FavoriteNavigationControllerDelegate.self, argument: c)!
            let viewModel = r.resolve(FavoriteViewModel.self)!
            let locationManager = r.resolve(LocationManager.self)!
            c.installDependencies(viewModel, navigationController, locationManager, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(SettingsViewController.self) { r, c in
            let navigationController = r.resolve(SettingsFlowControllerDelegate.self, argument: c)!
            c.installDependencies(navigationController, r.resolve(AdsSettings.self)!)
        }
        defaultContainer.storyboardInitCompleted(RemoveAdsViewController.self) { r, c in
            let viewModel = r.resolve(RemoveAdsViewModel.self)!
            c.installDependencies(viewModel, r.resolve(AdsSettings.self)!)
        }
    }
    
    fileprivate class func registerViewModels() {
        defaultContainer.register(HubViewModel.self) { r in
            HubViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(SearchViewModel.self) { r in
            SearchViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(BollardsViewModel.self) { r in
            BollardsViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(LineBollardsViewModel.self) { r in
            LineBollardsViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(BollardViewModel.self) { r in
            BollardViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(MapViewModel.self) { r in
            MapViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(FavoriteViewModel.self) { r in
            FavoriteViewModel(executor: r.resolve(Executor.self)!)
        }
        defaultContainer.register(RemoveAdsViewModel.self) { r in
            RemoveAdsViewModel(executor: r.resolve(Executor.self)!, adsSettings: r.resolve(AdsSettings.self)!)
        }
    }
    
    fileprivate class func registerCommands() {
        defaultContainer.register(CommandHandler.self, name: NSStringFromClass(ToggleBollardFavoriteCommand.self)) { r in
            ToggleBollardFavoriteCommandHandler(favoriteBollardsRepository: r.resolve(FavoriteBollardsRepository.self)!)
        }
        defaultContainer.register(CommandHandler.self, name: NSStringFromClass(SaveSearchResultCommand.self)) { r in
            SaveSearchResultCommandHandler(recentSearchRepository: r.resolve(RecentSearchRepository.self)!)
        }
    }
    
    fileprivate class func registerQueries() {
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetStopPointPushpinsQuery.self)) { r in
            GetStopPointPushpinsQueryHandler(apiProvider: r.resolve(RestApiProvider.self, name: stopPointsApiProvider)!, stopPointsCache: r.resolve(StopPointPushpinsCache.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(SearchQuery.self)) { r in
            SearchQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardsByStopPointQuery.self)) { r in
            GetBollardsByStopPointQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!, favoriteGroupedDirectionsComparator: r.resolve(FavoriteGroupedDirectionsComparator.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardsByStreetQuery.self)) { r in
            GetBollardsByStreetQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!, favoriteGroupedDirectionsComparator: r.resolve(FavoriteGroupedDirectionsComparator.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardsByLineQuery.self)) { r in
            GetBollardsByLineQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!, favoriteLineBollardsComparator: r.resolve(FavoriteLineBollardComparator.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetTimesQuery.self)) { r in
            GetTimesQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardQuery.self)) { r in
            GetBollardQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!, favoriteBollardComparator: r.resolve(FavoriteBollardComparator.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetFavoriteBollardsQuery.self)) { r in
            GetFavoriteBollardsQueryHandler(favoriteBollardsRepository: r.resolve(FavoriteBollardsRepository.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetBollardMessageQuery.self)) { r in
            GetBollardMessageQueryHandler(apiProvider: r.resolve(RestApiProvider.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetSearchHistoryQuery.self)) { r in
            GetSearchHistoryQueryHandler(recentSearchRepository: r.resolve(RecentSearchRepository.self)!)
        }
        defaultContainer.register(QueryHandler.self, name: NSStringFromClass(GetNearestStopQuery.self)) { r in
            GetNearestStopQueryHandler(stopPointsCache: r.resolve(StopPointPushpinsCache.self)!)
        }
    }
    
    fileprivate class func registerNavigationControllers() {
        defaultContainer.register(SearchNavigationControllerDelegate.self) { (_, arg: SearchViewController) in
            SearchNavigationController(viewController: arg)
        }
        defaultContainer.register(BollardsNavigationControllerDelegate.self) { (_, arg: BollardsViewController) in
            BollardsNavigationController(viewController: arg)
        }
        defaultContainer.register(LineBollardsNavigationControllerDelegate.self) { (_, arg: LineBollardsViewController) in
            LineBollardsNavigationController(viewController: arg)
        }
        defaultContainer.register(BollardNavigationControllerDelegate.self) { (_, arg: BollardViewController) in
            BollardNavigationController(viewController: arg)
        }
        defaultContainer.register(MapNavigationControllerDelegate.self) { (_, arg: MapViewController) in
            MapNavigationController(viewController: arg)
        }
        defaultContainer.register(FavoriteNavigationControllerDelegate.self) { (_, arg: FavoriteViewController) in
            FavoriteNavigationController(viewController: arg)
        }
        defaultContainer.register(SettingsFlowControllerDelegate.self) { (_, arg: SettingsViewController) in
            SettingsFlowController(viewController: arg)
        }
    }
}
