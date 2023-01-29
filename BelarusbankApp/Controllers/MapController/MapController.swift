//
//  MapController.swift
//  BelarusbankApp
//
//  Created by Georgy Finsky on 29.01.23.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils
import CoreLocation

class MapController: UIViewController {
    private let locationManager = CLLocationManager()
    private var clusterManager: GMUClusterManager!

    
    //MARK: -
    //MARK: IBOutlets
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var reloadDataButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
                
        setupUI()
    }
    
    private func setupUI() {
        self.topContainerView.layer.cornerRadius = 20
        self.topContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.mapView.isMyLocationEnabled = true
    }
    
    private func setupCluster() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: self.mapView, clusterIconGenerator: iconGenerator)
        
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setMapDelegate(self)
        clusterManager.cluster()
    }
    
    private func setupMapCamera(lat: Double, lon: Double, zoom: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: zoom)
        
        mapView?.animate(to: camera)
    }
    
}

//MARK: -
//MARK: CLLocationManagerDelegate
extension MapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location?.coordinate else { return }

        setupMapCamera(lat: userLocation.latitude, lon: userLocation.longitude, zoom: 12)
    }
    
}

//MARK: -
//MARK: GMSMapViewDelegate
extension MapController: GMSMapViewDelegate {
    
}
