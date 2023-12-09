//
//  LocationHelper.swift
//  CollegeDelivery
//
//  Created by Nicholas Fabek on 2023-12-08.
//

import Foundation
import CoreLocation

class LocationHelper : NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var currentLocation : CLLocation?
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    
    override init(){
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus{
            case .authorizedAlways:
                print(#function, "Always access granted for location")
                manager.startUpdatingLocation()
            case .authorizedWhenInUse:
                print(#function, "Foreground access granted for location")
                manager.startUpdatingLocation()
            case .notDetermined, .denied:
                print(#function, "location permission : \(manager.authorizationStatus)")
                manager.stopUpdatingLocation()
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print(#function, "location permission restricted")
                manager.requestAlwaysAuthorization()
                manager.requestWhenInUseAuthorization()
            @unknown default:
                print(#function, "location permission not received")
                manager.stopUpdatingLocation()
                manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.isEmpty){
            print(#function, "No location received")
        } else {
            if (locations.last != nil){
                print(#function, "Most recent location : \(String(describing: locations.last))")
                self.currentLocation = locations.last
            } else {
                print(#function, "previously known location : \(String(describing: locations.first))")
                self.currentLocation = locations.first
            }
            print(#function, "current location : \(String(describing: self.currentLocation))")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Unable to receive location changes due to error : \(error)")
    }
}
