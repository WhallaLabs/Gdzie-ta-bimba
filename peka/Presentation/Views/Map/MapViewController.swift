//
//  MapViewController.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit
import RxMKMapView

private let poznanCoordinates = CLLocationCoordinate2DMake(52.407720, 16.933497)

final class MapViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: MapViewModel!
    private var locationManager: LocationManager!

	@IBOutlet private weak var viewConfigurator: MapViewConfigurator!
    @IBOutlet private weak var mapView: MKMapView!

	func installDependencies(viewModel: MapViewModel, _ locationManager: LocationManager) {
		self.viewModel = viewModel
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewConfigurator.configure()
        self.mapView.delegate = self
        self.registerForEvents()
	}
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.mapView.showsUserLocation = self.locationManager.hasPermission
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.mapView.showsUserLocation = false
    }
	
    private func registerForEvents() {
        self.mapView.rx_didUpdateUserLocation.take(1)
            .map { $0.coordinate }
            .startWith(poznanCoordinates)
            .subscribeNext { [unowned self] coordinates in
                let region = MKCoordinateRegionMakeWithDistance(coordinates, 1000, 1000)
                self.mapView.setRegion(region, animated: true)
            }.addDisposableTo(self.disposables)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
