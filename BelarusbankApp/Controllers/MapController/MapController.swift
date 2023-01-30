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
    private var facilitys = [FacilityModel]()
    private var cites = [CityModel]()
    
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
        
        setupInitialUI()
        setupCluster()
        getData()
    }
    
    private func setupInitialUI() {
        self.topContainerView.layer.cornerRadius = 20
        self.topContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.topContainerView.isUserInteractionEnabled = false
        self.mapView.isMyLocationEnabled = true
        
        getDataUI(status: .sendRequest)
    }
    
    private func getDataUI(status: GetDataStatusType) {
        status == .sendRequest ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        reloadDataButton.isHidden = activityIndicator.isAnimating
        activityIndicator.isHidden = !reloadDataButton.isHidden
    }
    
    private func setupCluster() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: self.mapView, clusterIconGenerator: iconGenerator)
        
        renderer.delegate = self
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        clusterManager.setMapDelegate(self)
        clusterManager.cluster()
    }
    
    private func getData() {
        BankFacilityProvider().getATMs { [weak self] result in
            guard let self else { return }
            
            for item in result {
                self.decodeData(item: item, type: .atm)
            }
            self.getDataUI(status: .getResult)
        } failure: { errorString in
            print(errorString)
            self.getDataUI(status: .getResult)
        }
        
        BankFacilityProvider().getDepartments { [weak self] result in
            guard let self else { return }
            
            for item in result {
                self.decodeData(item: item, type: .department)
            }
            self.getDataUI(status: .getResult)
        } failure: { errorString in
            print(errorString)
            self.getDataUI(status: .getResult)
        }
    }
    
    private func decodeData<T: BankFacility>(item: T, type: FacilityType) {
        let facility = FacilityModel(type: type, id: item.id, city: item.city, coordinates: CLLocationCoordinate2D(latitude: Double(item.gpsX) ?? 0.0, longitude: Double(item.gpsY) ?? 0.0))
        
        self.facilitys.append(facility)
        
        self.clusterManager.add(FacilityMarker(facility: facility))
    }
    
    private func setupMapCamera(lat: Double, lon: Double, zoom: Float) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: zoom)
        
        mapView?.animate(to: camera)
    }
    
}

//MARK: -
//MARK: FacilityMarker
class FacilityMarker: GMSMarker {
    var facility: FacilityModel?
    
    convenience init(facility: FacilityModel) {
        self.init(position: facility.coordinates)
        self.facility = facility
        self.icon = facility.type.markerIcon
    }
    
}

//MARK: -
//MARK: FacilityModel
struct FacilityModel {
    var type: FacilityType
    var id: String
    var city: String
    var coordinates: CLLocationCoordinate2D
}

//MARK: -
//MARK: CityModel
struct CityModel {
    var name: String
    var atm: Bool
    var department: Bool
}

//MARK: -
//MARK: CLLocationManagerDelegate
extension MapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location?.coordinate else { return }
        
        self.locationManager.stopUpdatingLocation()
        setupMapCamera(lat: userLocation.latitude, lon: userLocation.longitude, zoom: 12)
    }
    
}

//MARK: -
//MARK: GMSMapViewDelegate
extension MapController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        
        if marker.userData is GMUCluster {
            mapView.animate(toZoom: mapView.camera.zoom + 1)
            return true
        }
        return false
    }
    
}

//MARK: -
//MARK: GMUClusterRendererDelegate
extension MapController: GMUClusterRendererDelegate {
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        if let facilityMarker = marker.userData as? FacilityMarker {
            marker.icon = facilityMarker.icon
        }
    }
    
}
