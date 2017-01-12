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
import RxOptional

private let poznanCoordinates = CLLocationCoordinate2DMake(52.407720, 16.933497)

final class MapViewController: UIViewController {

	fileprivate let disposables = DisposeBag()
	fileprivate var viewModel: MapViewModel!
    fileprivate var locationManager: LocationManager!
    fileprivate var navigationDelegate: MapNavigationControllerDelegate!
    fileprivate let clusteringManager = FBClusteringManager()

	@IBOutlet fileprivate weak var viewConfigurator: MapViewConfigurator!
    @IBOutlet fileprivate weak var mapView: MKMapView!
    @IBOutlet fileprivate weak var showUserLocationButton: UIButton!

	func installDependencies(_ viewModel: MapViewModel, _ navigationDelegate: MapNavigationControllerDelegate, _ locationManager: LocationManager) {
		self.viewModel = viewModel
        self.navigationDelegate = navigationDelegate
        self.locationManager = locationManager
	}

	override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.viewModel.loadStopPoints().addDisposableTo(self.disposables)
		self.viewConfigurator.configure()
        self.registerForEvents()
        self.setupBinding()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.mapView.showsUserLocation = self.locationManager.hasPermission
        self.showUserLocationButton.isHidden = self.locationManager.hasPermission == false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mapView.showsUserLocation = false
    }
	
    fileprivate func registerForEvents() {
        self.mapView.rx.didUpdateUserLocation.take(1)
            .map { $0.coordinate }
            .startWith(poznanCoordinates)
            .subscribeNext { [unowned self] coordinates in
                self.showRegion(coordinates)
            }.addDisposableTo(self.disposables)
        
        self.mapView.rx.didSelectAnnotationView.filter { $0.annotation is StopPointAnnotation }
            .subscribeNext { annotationView in
                let button = UIButton(type: .detailDisclosure)
                button.tintColor = UIColor(color: .backgroundLight)
                annotationView.rightCalloutAccessoryView = button
            }.addDisposableTo(self.disposables)
        
        self.mapView.rx.didSelectAnnotationView.map { $0.annotation as? FBAnnotationCluster }
            .filterNil()
            .map { $0.coordinate }
            .subscribeNext { [unowned self] coordinate in
                self.zoomToCluster(coordinate)
            }.addDisposableTo(self.disposables)
        
        self.mapView.rx.annotationViewCalloutAccessoryControlTapped.map { $0.view.annotation as? StopPointAnnotation }
            .filterNil()
            .subscribeNext { [unowned self] stopPointAnnotation in
                self.navigationDelegate.showBollard(stopPointAnnotation)
            }.addDisposableTo(self.disposables)
    }
    
    fileprivate func setupBinding() {
        self.viewModel.pushpins.asObservable()
            .filter{ $0.any() }
            .map(StopPointPushpinsToAnnotationsConverter())
            .subscribeNext { [unowned self] annotations in
                self.clusteringManager.add(annotations: annotations)
            }.addDisposableTo(self.disposables)
    }
    
    @IBAction fileprivate func showUserOnMap() {
        let location = self.mapView.userLocation.coordinate
        self.showRegion(location)
    }
    
    fileprivate func showRegion(_ coordinates: CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(coordinates, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    fileprivate func zoomToCluster(_ coordinates: CLLocationCoordinate2D) {
        var span = self.mapView.region.span
        span.latitudeDelta = span.latitudeDelta / 2
        span.longitudeDelta = span.longitudeDelta / 2
        let region = MKCoordinateRegionMake(coordinates, span)
        self.mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let clusterAnnotation = annotation as? FBAnnotationCluster {
            return FBAnnotationClusterView(annotation: clusterAnnotation)
        }
        if let stopPointAnnotation = annotation as? StopPointAnnotation {
            let pushpinView = mapView.dequeueReusableAnnotationView(withIdentifier: Pushpin.identifier) as? Pushpin ?? Pushpin(pushpinAnnotation: stopPointAnnotation)
            return pushpinView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        OperationQueue().addOperation { 
            let mapBoundsWidth = Double(self.mapView.bounds.size.width)
            let mapRectWidth: Double = self.mapView.visibleMapRect.size.width
            let scale: Double = mapBoundsWidth / mapRectWidth
            let annotations = self.clusteringManager.clusteredAnnotations(withinMapRect: self.mapView.visibleMapRect, zoomScale: scale)
            self.clusteringManager.display(annotations: annotations, onMapView: self.mapView)
        }
    }
}
