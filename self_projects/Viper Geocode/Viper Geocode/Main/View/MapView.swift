//
//  MapMainView.swift
//  Viper Geocode
//
//  Created by rafaeldelegate on 8/10/19.
//  Copyright © 2019 rafaeldelegate. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
// Map page UI
//View — Responsibility of view is to send user actions to the presenter and show whatever the presenter asks it to.
class MapView: UIViewController , MapViewProtocol{
    
    func setupMapConfiguration() {
        map.register(PinMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        map.delegate = self
        checkLocationServices()
        initialLocation()
    }
    func setupCustomSearchTextViewDelegate(){
        searchBarTextView.delegate = self
    }
    func printText(_ text: String) {
        print("Map view protocol")
        print(text)
    }
    func reloadMapItens(with itens:[Pin]){
        if itens.count > 0 {
            let annotationsToRemove = map.annotations.filter { $0 !== map.userLocation }
            map.removeAnnotations( annotationsToRemove )
            
            for i in 0...itens.count - 1 {
                self.pins.append(itens[i])
                self.map.addAnnotation(itens[i])
            }
            view.layoutIfNeeded()
        }
    }
    var pins : [Pin] = []
    var map : MKMapView = {
        var map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    var searchBarTextView : UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.backgroundColor = .purple
        textView.layer.cornerRadius = 12
        textView.isUserInteractionEnabled = true
        return textView
    }()
    let debouncer = Debouncer(timeInterval: 1)
    var presenter : MapPresenterProtocol?
    
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 1000
    var placemark:CLPlacemark?
    var previousLocation : CLLocation?
    var placeMarks : [CLPlacemark] = []
    var isEditingMap : Bool = false
    
    fileprivate func setupView() {
        view.backgroundColor = .purple
        view.addSubview(map)
        map.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        view.addSubview(searchBarTextView)
        searchBarTextView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        MapWireframe.createMapModule(mapRef: self)
        presenter?.viewDidLoad()
        setupCustomSearchTextViewDelegate()
        //reloadMapItens()
    }
    
    // MARK: - Map methods
    func initialLocation(){
        previousLocation = getCenterLocation(for: map)
    }
        func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func startTrackingUserLocation() {
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: map)
        print(previousLocation!)
    }
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            map.setRegion(region, animated: true)
        }
    }
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            let alert = Alert(controller: self)
            alert.show("Atention", message: "Location services are not enabled. This allow us to use your location to provide features like tracking your preferred spots based on your current location") {
            }
        }
    }
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            print("alive")
            centerViewOnUserLocation()
            break
        case .denied :
            let alert = Alert(controller: self)
            alert.show("Atention", message: "This allow us to use your location to provide features like tracking your preferred spots based on your current location") {
            }
            alert.show("Atention", message: "Location permissions denied. Please check manually if location services are enabled.") {
            }
            break
        case .notDetermined :
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted :
            let alert = Alert(controller: self)
            alert.show("Atention", message: "Location permissions denied by a restricted location services") {
            }
            break
        case .authorizedAlways :
            break
        @unknown default:
            break
        }
    }
}

extension MapView : UITextViewDelegate {
    
    func textDidChangeRenewInterval(){
        debouncer.renewInterval()
    }
    func textViewDidChange(_ textView: UITextView) {
        textDidChangeRenewInterval()
        debouncer.handler = {
            print("test")
            self.presenter?.printText(textView.text)
        }
    }
}

extension MapView : MKMapViewDelegate {
    
    func getCenterLocation(for mapview: MKMapView) -> CLLocation {
        let latitude = mapview.centerCoordinate.latitude
        let longitude = mapview.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getPlacemark(completion: @escaping() -> Void){
        let center = getCenterLocation(for: map)
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(center) { (placemarks, error) in
            if let _ = error {
                //TO DO Show alert inform the user
                return
            }
            guard let placemark = placemarks?.first else {
                //TO DO Show alert informing the user
                return
            }
            self.placemark = placemark
            
            print("self.placemark\(String(describing: self.placemark))")
            completion()
        }
    }
    
    func getCenterAnnotation(){
        
        let center = getCenterLocation(for: map)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else {return}
            if let _ = error {
                //TO DO Show alert inform the user
                return
            }
            guard let placemark = placemarks?.first else {
                //TO DO Show alert informing the user
                return
            }
            self.placeMarks.append(placemark)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        if isEditingMap {
            let center = getCenterLocation(for: mapView)
            let geoCoder = CLGeocoder()
            guard let previousLocation = self.previousLocation else {return}
            guard center.distance(from: previousLocation) > 5 else {return}
            self.previousLocation = center
            
            geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
                guard let self = self else {return}
                if let _ = error {
                    //TO DO Show alert inform the user
                    return
                }
                guard let placemark = placemarks?.first else {
                    //TO DO Show alert informing the user
                    return
                }
                let streetNumber = placemark.subThoroughfare ?? "terra indigena"
                let streetName = placemark.thoroughfare ?? "número indígena"
                
//                DispatchQueue.main.async {
//                    self.viewMain.textViewAdress.text = "You are in \(streetName) \(streetNumber)"
//                }
            }
        }
    }
}
extension MapView : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        map.setRegion(region, animated: true   )
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
