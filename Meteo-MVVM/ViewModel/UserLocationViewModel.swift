//
//  UserLocationViewModel.swift
//  Meteo-MVVM
//
//  Created by Thomas George on 19/03/2022.
//

import SwiftUI
import CoreLocation
import MapKit

class UserLocationViewModel: NSObject, ObservableObject  {
    
    // MARK: - PROPERTIES

    private let manager: CLLocationManager = CLLocationManager()
    private let geocoder: CLGeocoder = CLGeocoder()
    
    var authorizationStatus: CLAuthorizationStatus?
    
    // MARK: - DATA BINDING
    
    @Published var userLocation: UserLocation?
    @Published var isLocatingMe: Bool = true
    
    // MARK: - INIT
    
    override init() {
        super.init()
        
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.distanceFilter = 1000
        
        self.updateLocation()
    }
    
    // MARK: - FUNCTIONS
    
    func updateLocation() {
        self.isLocatingMe ? self.manager.startUpdatingLocation() : self.manager.stopUpdatingLocation()
    }
    
    func toggleLocation() {
        self.isLocatingMe.toggle()
        self.updateLocation()
    }
    
    func convertCoordinates(location: CLLocation) {
        self.geocoder.reverseGeocodeLocation(location, completionHandler: self.geocodeCompletionHandler(placemarks:error:))
    }
    
    func convertAddress(address: String) {
        self.isLocatingMe = false
        self.manager.stopUpdatingLocation()
        self.geocoder.geocodeAddressString(address, completionHandler: self.geocodeCompletionHandler(placemarks:error:))
    }
    
    func geocodeCompletionHandler(placemarks: [CLPlacemark]?, error: Error?) {
        guard let placemark = placemarks?.first else { return }
        let city = placemark.locality ?? ""
        let country = placemark.country ?? ""
        
        let coordinates = placemark.location?.coordinate
        let latitude = coordinates?.latitude ?? 0
        let longitude = coordinates?.longitude ?? 0
        
        let newUserLocation = UserLocation(latitude: latitude, longitude: longitude, city: city, country: country)
        self.userLocation = newUserLocation
    }
    
    func setRegion(userLocation: UserLocation) -> MKCoordinateRegion {
        let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        return MKCoordinateRegion(center: center, span: span)
    }
}

// MARK: - LOCATION MANAGER DELEGATE

extension UserLocationViewModel: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(self.manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let last = locations.last else { return }
        self.convertCoordinates(location: last)
    }
    
}
