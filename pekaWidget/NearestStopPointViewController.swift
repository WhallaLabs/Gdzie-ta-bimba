//
//  NearestStopPointViewController.swift
//  pekaWidget
//
//  Created by Wojciech Świerczyk on 20.01.2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import SwinjectStoryboard
import Swinject
import NotificationCenter

final class NearestStopPointViewController: UIViewController, NCWidgetProviding {
    
    private var viewModel: NearestStopPointViewModel!
    private var locationManager: LocationManager!
    private let disposables = DisposeBag()
    private var refreshableDisposables = DisposeBag()
    private let disableEditingBehavior = DisableEditingTableViewDelegate()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeader: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(WidgetCell.self)
        if #available(iOS 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
        self.tableView.rx.setDelegate(self.disableEditingBehavior).addDisposableTo(self.disposables)
        self.setupBinding()
    }
    
    @available(iOS 10.0, *)
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        switch activeDisplayMode {
        case .expanded:
            let headerHeight = CGFloat(28)
            let rowHeight = CGFloat(40)
            let rows = CGFloat(max(1, self.viewModel.times.value.count))
            let height = rows * rowHeight + headerHeight
            self.preferredContentSize = CGSize(width: maxSize.width, height: height)
        case .compact:
            self.preferredContentSize = maxSize
        }
    }
    
    func installDependencies(_ viewModel: NearestStopPointViewModel, _ locationManager: LocationManager) {
        self.viewModel = viewModel
        self.locationManager = locationManager
    }
    
    fileprivate func setupBinding() {
        self.viewModel.times
            .asObservable()
            .bindTo(self.tableView.configurableCells(WidgetCell.self))
            .addDisposableTo(self.disposables)
        let sampler = Observable<Int>.timer(0, period: 30, scheduler: MainScheduler.asyncInstance).asObservable()
        self.viewModel.nearestStopPoint
            .asObservable()
            .filterNil()
            .map { $0.id }
            .flatMapLatest { [unowned self] symbol in self.viewModel.loadTimes(symbol).sample(sampler) }
            .subscribe()
            .addDisposableTo(self.disposables)
        self.viewModel.nearestStopPoint
            .asObservable()
            .filterNil()
            .map { $0.name }
            .bindTo(self.tableViewHeader.rx.text)
            .addDisposableTo(self.disposables)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        self.refreshableDisposables = DisposeBag()
        
        self.viewModel.initializeNearestStopPoints(self.locationManager.userLocation()).subscribe(onNext: { [unowned self] (stopPoint) in
            if self.viewModel.nearestStopPoint.value == stopPoint {
                completionHandler(.noData)
            } else {
                self.viewModel.nearestStopPoint.value = stopPoint
                completionHandler(.newData)
            }
        }, onError: { (error) in
            completionHandler(.failed)
        }).addDisposableTo(self.refreshableDisposables)
    }
    
    deinit {
        debugPrint("WIDGET - deinit")
    }
    
}
