//
//  TodayViewController.swift
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

class TodayViewController: UIViewController, NCWidgetProviding {
    
    fileprivate var viewModel: TodayViewModel!
    fileprivate var locationManager: LocationManager!
    fileprivate let disposables = DisposeBag()
    fileprivate let disableEditingBehavior = DisableEditingTableViewDelegate()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshLabel: UILabel!
    @IBOutlet weak var tableViewHeader: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:400)
        self.configureTableView()
        if #available(iOS 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
        self.tableView.rx.setDelegate(self.disableEditingBehavior).addDisposableTo(self.disposables)
        self.viewModel.initializeNearestStopPoints(self.locationManager.userLocation()).addDisposableTo(self.disposables)
        self.setupBinding()
        self.refreshLabel.text = "RefreshDepartures".localized.uppercased()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        SwinjectStoryboard.setupWidget()
    }
    
    @available(iOS 10.0, *)
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 400)
        } else if activeDisplayMode == .compact{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
        }
    }
    
    func installDependencies(_ viewModel: TodayViewModel, _ locationManager: LocationManager) {
        self.viewModel = viewModel
        self.locationManager = locationManager
    }
    
    @IBAction func refreshTimes() {
        
    }
    
    
    fileprivate func setupBinding() {
        self.viewModel.times.asObservable()
            .bindTo(self.tableView.configurableCells(WidgetCell.self))
            .addDisposableTo(self.disposables)
        self.viewModel.nearestStopPoint.asObservable()
            .map { $0.first?.id }
            .filterNil()
            .flatMap { self.viewModel.loadTimesAndMessage($0) }
            .subscribe()
            .addDisposableTo(self.disposables)
        self.viewModel.nearestStopPoint
            .asObservable()
            .map { $0.first?.name }
            .filterNil()
            .bindTo(self.tableViewHeader.rx.text)
            .addDisposableTo(self.disposables)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
       // self.viewModel.initializeNearestStopPoints(self.locationManager.userLocation()).addDisposableTo(self.disposables)
        completionHandler(NCUpdateResult.newData)
    }
    
    private func configureTableView() {
        self.tableView.register(WidgetCell.self)
    }
    
}
