//
//  LocationManager.swift
//  Mun
//
//  Created by Tomás García Gobet on 17.09.23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            manager.requestLocation()
            self.location = manager.location?.coordinate
            break
            
        case .restricted, .denied:
            self.location = nil
            break
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
   }
}
