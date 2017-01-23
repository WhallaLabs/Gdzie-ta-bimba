//
//  TodayViewController.swift
//  pekaWidget
//
//  Created by Wojciech Świerczyk on 20.01.2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    fileprivate var viewModel: TodayViewModel!
    fileprivate var locationManager: LocationManager!
    fileprivate let disposables = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        self.preferredContentSize = CGSize(width:self.view.frame.size.width, height:400)
        self.locationManager = PekaLocationManager()
        self.viewModel = TodayViewModel(executor: Executor())
        
        if #available(iOS 10.0, *) {
            self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        }
        
    }
    
    @available(iOS 10.0, *)
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 400)
        }else if activeDisplayMode == .compact{
            self.preferredContentSize = CGSize(width: maxSize.width, height: 110)
        }
    }
    
    func installDependencies(_ viewModel: TodayViewModel, _ locationManager: LocationManager) {
        
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
    
}
