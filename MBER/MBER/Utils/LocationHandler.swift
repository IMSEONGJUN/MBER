//
//  LocationManager.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/12.
//

import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
    var locationManager: CLLocationManager
    var location: CLLocation?
    
    private override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let accuracyAuthorization = manager.accuracyAuthorization
            switch accuracyAuthorization {
            case .fullAccuracy:
                fallthrough
            case .reducedAccuracy:
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
            default:
                break
            }
    }
}
