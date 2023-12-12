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
    @Published var targetLocation: CLLocation?
    @Published var showCurrentLocationToggle: Bool = false
    private let locationManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
   
    
    
    override init(){
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
    }
   
    
    
    func showCurrentLocation() {
        showCurrentLocationToggle = true
    }
   
    
    
    func showTargetLocation() {
        showCurrentLocationToggle = false
    }
    
    
    
    func setTargetLocationTo(address: String) {
        performForwardGeocoding(address: address)
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
   
    
    
    func performForwardGeocoding(address : String) {
        self.geoCoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            if (error == nil) {
                if (placemarks != nil){
                    if let location = placemarks!.first{
                        print(#function, "obtained location : \(location)")
                        self.targetLocation = location.location
                    }
                } else {
                    print(#function, "No matching coordinates for given address")
                }
            } else {
                print(#function, "Coordinates for given address is not available : \(String(describing: error))")
            }
        })
    }

    
    
    func performReverseGeocoding(location : CLLocation, completionHandler : @escaping(String?, NSError?) -> Void) {
        self.geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarkList, error) in
            if (error != nil){
                print(#function, "Couldn't perform reverse geocoding successfully due to error : \(String(describing: error))")
                completionHandler(nil, error as? NSError)
            } else {
                if let addresses = placemarkList {
                    print(#function, "\(addresses.count) addresses found")
                    print(#function, "name : \(String(describing: addresses.last?.name))")
                    for address in addresses {
                        print(#function, "name : \(String(describing: address.name))")
                        print(#function, "street number : \(String(describing: address.subThoroughfare))")
                        print(#function, "street name : \(String(describing: address.thoroughfare))")
                        print(#function, "city : \(String(describing: address.locality))")
                        print(#function, "postal code : \(String(describing: address.postalCode))")
                        print(#function, "province : \(String(describing: address.administrativeArea))")
                        print(#function, "country : \(String(describing: address.country))")
                        print(#function, "country code : \(String(describing: address.isoCountryCode))")
                    }
                    let address = addresses.last
                    var resultAddress = "NA"
                    if (address != nil){
                        resultAddress = "resultAddress : \n\(address!.subThoroughfare ?? "NA") \(address!.thoroughfare ?? "NA"), \n\(address!.locality ?? "NA"). \(address!.postalCode ?? "NA")"
                    }
                    print(#function, "resultAddress : \(resultAddress)")
                    completionHandler(resultAddress, nil)
                } else {
                    completionHandler("No addresses found", nil)
                }
            }
        })
    }
    
    
    
}
