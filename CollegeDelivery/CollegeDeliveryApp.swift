//
//  CollegeDeliveryApp.swift
//  CollegeDelivery
//
//  Created by Mohammed Siddiqui on 2023-11-28.
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct CollegeDeliveryApp: App {
    
    let fireDBHelper : FireDBHelper
    let locationHelper: LocationHelper
    
    init() {
        FirebaseApp.configure()
        fireDBHelper = FireDBHelper.getInstance()
        locationHelper = LocationHelper()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView().environmentObject(fireDBHelper)
            HomePage().environmentObject(fireDBHelper).environmentObject(locationHelper)
        }
    }
}
