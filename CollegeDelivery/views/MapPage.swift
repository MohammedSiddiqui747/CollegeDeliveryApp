//
//  MapView.swift
//  CollegeDelivery
//
//  Created by Nicholas Fabek on 2023-12-08.
//

import Foundation
import SwiftUI
import MapKit

struct MapPage: View {
    @EnvironmentObject var locationHelper : LocationHelper
    
    var body: some View {
        NavigationView{
            VStack{
                if (self.locationHelper.currentLocation != nil){
                    MyMap().environmentObject(self.locationHelper)
                        .edgesIgnoringSafeArea(.top)
                } else {
                    Text("Map unavailable!")
                }
            }
            .onAppear(){
                //
            }
        }
    }
}

struct MyMap : UIViewRepresentable{
    
    typealias UIViewType = MKMapView
    
    @EnvironmentObject var locationHelper : LocationHelper
    
    // INITIAL MAP VIEW
    func makeUIView(context: Context) -> MKMapView {
        let centerPoint : CLLocationCoordinate2D
        if (self.locationHelper.currentLocation != nil){
            centerPoint = self.locationHelper.currentLocation!.coordinate
        } else{
            centerPoint = CLLocationCoordinate2D(latitude: 43.8595, longitude: -79.2345)
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: centerPoint, span: span)
        let map = MKMapView()
        map.setRegion(region, animated: true)
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsUserLocation = true
        map.isPitchEnabled = true
        map.mapType = .standard
        return map
        
    }
    
    // UPDATED MAP VIEW
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // CENTER POINT
        let centerPoint : CLLocationCoordinate2D
        if (self.locationHelper.currentLocation != nil){
            centerPoint = self.locationHelper.currentLocation!.coordinate
        } else {
            centerPoint = CLLocationCoordinate2D(latitude: 43.8595, longitude: -79.2345)
        }
        
        // REGION
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: centerPoint, span: span)
        uiView.setRegion(region, animated: true)
        
        // PIN
        let pin = MKPointAnnotation()
        pin.coordinate = centerPoint
        pin.title = "Current Location"
        uiView.addAnnotation(pin)
    }
    
}

