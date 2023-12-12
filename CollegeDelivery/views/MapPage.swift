//
//  MapView.swift
//  CollegeDelivery
//
//  Created by Nicholas Fabek on 2023-12-08.
//

// The commented out code is from an attempt at getting directions working...


import Foundation
import SwiftUI
import MapKit

struct MapPage: View {
    @EnvironmentObject var locationHelper : LocationHelper
    @State private var selectedOption = 0
    let options = ["Trafalgar", "Hazel McCallion", "Davis"]
    let addresses = ["1430 Trafalgar Rd, Oakville, Canada", "4180 Duke of York, Missisauga, Canada", "7899 McLaughlin Rd, Brampton, Canada"]
    /*
    @State private var sourceCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // San Francisco
    @State private var destinationCoordinate = CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437) // Los Angeles
    @State private var directions: MKDirections?
     */
    
    var body: some View {
        NavigationView{
            VStack{
                if (self.locationHelper.currentLocation != nil){
                    MyMap(
                        /*
                        sourceCoordinate: $sourceCoordinate,
                        destinationCoordinate: $destinationCoordinate,
                        directions: $directions
                         */
                    )
                        .environmentObject(self.locationHelper)
                        .edgesIgnoringSafeArea(.top)
                } else {
                    Text("Map unavailable!")
                }
                /*
                HStack {
                    Spacer() // Push the icon to the right
                        .background(Color.clear)
                    Button(action: {
                        self.locationHelper.showCurrentLocation()
                    }) {
                        Image(systemName: "scope")
                            .font(.system(size: 52))
                            .foregroundColor(.blue)
                            .background(Color.clear)
                    }
                    .background(Color.clear)
                }
                .background(Color.clear)
                 */
                Picker("Options", selection: $selectedOption) {
                    ForEach(0..<3) { index in
                        Text(self.options[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Button(action: {
                    self.locationHelper.showCurrentLocation()
                }) {
                    Text("Current Location")
                        .frame(height: 20)
                }
            }
            .onChange(of: selectedOption) { index in
                print("SET TARGET LOCATION TO \(self.addresses[index])")
                self.locationHelper.setTargetLocationTo(address: self.addresses[index])
                self.locationHelper.showTargetLocation()
            }
            .onAppear(){
                //
            }
        }
    }
    
    /*
    func calculateDirections() {
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .automobile

        directions = MKDirections(request: request)
        directions?.calculate { response, error in
            if let route = response?.routes.first {
                // Add the route to your map as an overlay
            }
        }
    }
     */
}

struct MyMap : UIViewRepresentable{
    typealias UIViewType = MKMapView
    @EnvironmentObject var locationHelper : LocationHelper
    
    /*
    @Binding var sourceCoordinate: CLLocationCoordinate2D
    @Binding var destinationCoordinate: CLLocationCoordinate2D
    @Binding var directions: MKDirections?
     */
    
    // INITIAL MAP VIEW
    func makeUIView(context: Context) -> MKMapView {
        let centerPoint : CLLocationCoordinate2D
        if (self.locationHelper.targetLocation != nil){
            centerPoint = self.locationHelper.targetLocation!.coordinate
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
        
        if (self.locationHelper.showCurrentLocationToggle == true && self.locationHelper.currentLocation != nil){
            centerPoint = self.locationHelper.currentLocation!.coordinate
        }
        else if (self.locationHelper.targetLocation != nil){
            centerPoint = self.locationHelper.targetLocation!.coordinate
            print("\(centerPoint)")
        } else {
            centerPoint = CLLocationCoordinate2D(latitude: 43.8595, longitude: -79.2345)
            print("\(centerPoint)")
        }
        
        // REGION
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        print("\(centerPoint)")
        let region = MKCoordinateRegion(center: centerPoint, span: span)
        uiView.setRegion(region, animated: true)
        
        // PIN
        let pin = MKPointAnnotation()
        pin.coordinate = centerPoint
        pin.title = "Current Location"
        uiView.addAnnotation(pin)
        
        /*
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.coordinate = sourceCoordinate
        sourceAnnotation.title = "Source"
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.coordinate = destinationCoordinate
        destinationAnnotation.title = "Destination"
        
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations([sourceAnnotation, destinationAnnotation])
        
        if let directions = directions {
            uiView.removeOverlays(uiView.overlays)
            directions.calculate { response, error in
                if let route = response?.routes.first {
                    uiView.addOverlay(route.polyline, level: .aboveRoads)
                }
            }
        }
         */

    }
    
    /*
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MyMap

        init(_ parent: MyMap) {
            self.parent = parent
        }

        func mapView(_ mapview: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if overlay is MKPolyline {
                let renderer = MKPolygonRenderer(overlay: overlay)
                renderer.strokeColor = UIColor.blue
                renderer.lineWidth = 4
                return renderer
            }
            return renderer(overlay: overlay)
        }
    }
     */
    
}






