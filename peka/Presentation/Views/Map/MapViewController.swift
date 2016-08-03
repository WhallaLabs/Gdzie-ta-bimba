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
import RxOptional

private let poznanCoordinates = CLLocationCoordinate2DMake(52.407720, 16.933497)

final class MapViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: MapViewModel!
    private var locationManager: LocationManager!
    private var navigationDelegate: MapNavigationControllerDelegate!

	@IBOutlet private weak var viewConfigurator: MapViewConfigurator!
    @IBOutlet private weak var mapView: MKMapView!

	func installDependencies(viewModel: MapViewModel, _ navigationDelegate: MapNavigationControllerDelegate, _ locationManager: LocationManager) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
		super.viewDidLoad()
        self.viewModel.loadStopPoints().addDisposableTo(self.disposables)
		self.viewConfigurator.configure()
        self.registerForEvents()
        self.setupBinding()
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
        
        self.mapView.rx_didSelectAnnotationView.filter { $0.annotation is StopPointAnnotation }
            .subscribeNext { annotationView in
                annotationView.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }.addDisposableTo(self.disposables)
        
        self.mapView.rx_annotationViewCalloutAccessoryControlTapped.map { $0.view.annotation as? StopPointAnnotation }
            .filterNil()
            .subscribeNext { [unowned self] stopPointAnnotation in
                self.navigationDelegate.showBollard(stopPointAnnotation)
            }.addDisposableTo(self.disposables)
    }
    
    private func setupBinding() {
        self.viewModel.pushpins.asObservable()
            .filter{ $0.any() }
            .map(StopPointPushpinsToAnnotationsConverter())
            .subscribeNext { [unowned self] annotations in
                self.mapView.removeAnnotations(self.mapView.annotations)
                self.mapView.addAnnotations(annotations)
            }.addDisposableTo(self.disposables)
    }
}
