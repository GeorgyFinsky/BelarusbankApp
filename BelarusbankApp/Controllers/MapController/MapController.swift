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
    private var selectedCity: CityModel? {
        didSet {
            facilityTypeCollection.reloadData()
        }
    }
    
    //MARK: -
    //MARK: IBOutlets
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var reloadDataButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    @IBOutlet weak var facilityTypeCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        cityCollectionView.dataSource = self
        facilityTypeCollection.dataSource = self
        
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
            self.getNearestCity()
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
            self.getNearestCity()
            self.getDataUI(status: .getResult)
        } failure: { errorString in
            print(errorString)
            self.getDataUI(status: .getResult)
        }
    }
    
    private func decodeData<T: BankFacility>(item: T, type: FacilityType) {
        let facility = FacilityModel(type: type, id: item.id, city: item.city, coordinates: CLLocation(latitude: Double(item.gpsX) ?? 0.0, longitude: Double(item.gpsY) ?? 0.0))
        
        self.facilitys.append(facility)
        
        self.clusterManager.add(FacilityMarker(facility: facility))
    }
    
    private func getCites(city: String, type: FacilityType) {
        if let index = self.cites.firstIndex(where: { $0.name == city }) {
            switch type {
                case .atm: cites[index].atm = true
                case .department: cites[index].department = true
                default: break
            }
        } else {
            switch type {
                case .atm: cites.append(CityModel(name: city, atm: true, department: false))
                case .department: cites.append(CityModel(name: city, atm: false, department: true))
                default: break
            }
        }
        self.cites = cites.sorted { $0.name < $1.name }
        getNearestCity()
    }
    
    private func getNearestCity() {
        guard let userLocation = locationManager.location else { return }
        var nearestFacilityDistance: (String, Double) = ("Минск", 700000)
          
        facilitys.forEach { facility in
            let distance = userLocation.distance(from: facility.coordinates)
            
            if distance < nearestFacilityDistance.1 {
                nearestFacilityDistance = (facility.city, distance)
            }
        }
        self.selectedCity = cites.first(where: { $0.name == nearestFacilityDistance.0 })
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
        self.init(position: CLLocationCoordinate2D(latitude: facility.coordinates.coordinate.latitude, longitude:  facility.coordinates.coordinate.longitude))
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
    var coordinates: CLLocation
}

//MARK: -
//MARK: CityModel
struct CityModel {
    var name: String
    var atm: Bool
    var department: Bool
    
    var filterArray: [String] {
        var filter: [String]
        if atm {
            filter.append(FacilityType.atm.rawValue)
        }
        if department {
            filter.append(FacilityType.department.rawValue)
        }
        if filter.count == 2 {
            filter.append(FacilityType.all.rawValue)
        }
        return filter
    }
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

//MARK: -
//MARK: UICollectionViewDataSource
extension MapController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cites.count
        } else {
            return selectedCity?.filterArray.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
}
