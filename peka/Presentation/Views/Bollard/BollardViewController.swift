//
//  BollardViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 02/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class BollardViewController: UIViewController {

    private let disposables = DisposeBag()
    private let disableEditingBehavior = DisableEditingTableViewDelegate()
	private var viewModel: BollardViewModel!
	private var navigationDelegate: BollardNavigationControllerDelegate!
    private let favoriteStateToImageConverter = FavoriteStateToImageConverter()

	@IBOutlet private weak var viewConfigurator: BollardViewConfigurator!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var toggleFavoriteButton: UIBarButtonItem!
    @IBOutlet private weak var messageBubble: MessageBubbleView!
	func installDependencies(viewModel: BollardViewModel, _ navigationDelegate: BollardNavigationControllerDelegate) {
		self.viewModel = viewModel
		self.navigationDelegate = navigationDelegate
	}
    
    func loadBollard(symbol: String) {
        self.viewModel.loadBollard(symbol).addDisposableTo(self.disposables)
    }
    
    func loadTimes(bollard: Bollard) {
        self.viewModel.loadTimesForBollard(bollard).addDisposableTo(self.disposables)
    }

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.setupBinding()
        self.tableView.rx_setDelegate(self.disableEditingBehavior)
	}
	
    private func setupBinding() {
        self.viewModel.times.asObservable()
            .bindTo(self.tableView.configurableCells(TimeCell.self))
            .addDisposableTo(self.disposables)
        
        let bollardObservable = self.viewModel.bollard.asObservable().filterNil()
        
        bollardObservable.map(self.favoriteStateToImageConverter).subscribeNext { [unowned self] image in
            self.toggleFavoriteButton.image = image
        }.addDisposableTo(self.disposables)
        
        self.viewModel.message.asObservable()
            .bindTo(self.messageBubble.content)
            .addDisposableTo(self.disposables)
        
        self.viewModel.message.asObservable()
            .map(IsNilConverter())
            .map { $0 ? CGFloat(0) : CGFloat(36) }
            .subscribeNext { [unowned self] messageHeight in
                let inset = UIEdgeInsetsMake(0, 0, messageHeight, 0)
                self.tableView.contentInset = inset
                self.tableView.scrollIndicatorInsets = inset
            }.addDisposableTo(self.disposables)
    }
    
    @IBAction private func toggleFavorite() {
        self.viewModel.toggleFavorite()
    }
}
