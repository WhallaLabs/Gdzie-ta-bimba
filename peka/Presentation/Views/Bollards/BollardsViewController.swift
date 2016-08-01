//
//  BollardsViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BollardsViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: BollardsViewModel!
	private var navigationDelegate: BollardsNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: BollardsViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    
	func installDependencies(viewModel: BollardsViewModel, _ navigationDelegate: BollardsNavigationControllerDelegate) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
	}
    
    func loadBollardsByStop(name: String) {
        
    }
    
    func loadBoolardsByStreet(name: String) {
        
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
	}
	
}
