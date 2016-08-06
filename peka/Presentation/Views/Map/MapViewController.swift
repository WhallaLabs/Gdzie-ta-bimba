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
import FBAnnotationClusteringSwift

private let poznanCoordinates = CLLocationCoordinate2DMake(52.407720, 16.933497)

final class MapViewController: UIViewController {

	private let disposables = DisposeBag()
	private var viewModel: MapViewModel!
    private var locationManager: LocationManager!
    private var navigationDelegate: MapNavigationControllerDelegate!
    private let clusteringManager = FBClusteringManager()

	@IBOutlet private weak var viewConfigurator: MapViewConfigurator!
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var showUserLocationButton: UIButton!

	func installDependencies(viewModel: MapViewModel, _ navigationDelegate: MapNavigationControllerDelegate, _ locationManager: LocationManager) {
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.mapView.showsUserLocation = self.locationManager.hasPermission
        self.showUserLocationButton.hidden = self.locationManager.hasPermission == false
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
                self.showRegion(coordinates)
            }.addDisposableTo(self.disposables)
        
        self.mapView.rx_didSelectAnnotationView.filter { $0.annotation is StopPointAnnotation }
            .subscribeNext { annotationView in
                let button = UIButton(type: .DetailDisclosure)
                button.tintColor = UIColor(color: .BackgroundLight)
                annotationView.rightCalloutAccessoryView = button
            }.addDisposableTo(self.disposables)
        
        self.mapView.rx_didSelectAnnotationView.map { $0.annotation as? FBAnnotationCluster }
            .filterNil()
            .map { $0.coordinate }
            .subscribeNext { [unowned self] coordinate in
                self.zoomToCluster(coordinate)
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
                self.clusteringManager.addAnnotations(annotations)
            }.addDisposableTo(self.disposables)
    }
    
    @IBAction private func showUserOnMap() {
        let location = self.mapView.userLocation.coordinate
        self.showRegion(location)
    }
    
    private func showRegion(coordinates: CLLocationCoordinate2D) {
        let region = MKCoordinateRegionMakeWithDistance(coordinates, 1000, 1000)
        self.mapView.setRegion(region, animated: true)
    }
    
    private func zoomToCluster(coordinates: CLLocationCoordinate2D) {
        var span = self.mapView.region.span
        span.latitudeDelta = span.latitudeDelta / 2
        span.longitudeDelta = span.longitudeDelta / 2
        let region = MKCoordinateRegionMake(coordinates, span)
        self.mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let clusterAnnotation = annotation as? FBAnnotationCluster {
            return FBAnnotationClusterView(annotation: clusterAnnotation)
        }
        if let stopPointAnnotation = annotation as? StopPointAnnotation {
            let pushpinView = mapView.dequeueReusableAnnotationViewWithIdentifier(Pushpin.identifier) as? Pushpin ?? Pushpin(pushpinAnnotation: stopPointAnnotation)
            return pushpinView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        NSOperationQueue().addOperationWithBlock { 
            let mapBoundsWidth = Double(self.mapView.bounds.size.width)
            let mapRectWidth: Double = self.mapView.visibleMapRect.size.width
            let scale: Double = mapBoundsWidth / mapRectWidth
            
            let annotations = self.clusteringManager.clusteredAnnotationsWithinMapRect(self.mapView.visibleMapRect, withZoomScale:scale)
            self.clusteringManager.displayAnnotations(annotations, onMapView: self.mapView)
        }
    }
}
