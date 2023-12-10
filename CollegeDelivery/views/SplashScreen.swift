//
//  SplashScreen.swift
//  CollegeDelivery
//
//  Created by Nicholas Fabek on 2023-12-09.
//

import SwiftUI

struct SplashScreen: View {
    @EnvironmentObject var fireDBHelper : FireDBHelper
    @EnvironmentObject var locationHelper : LocationHelper
    
    @State private var exitSplashScreen = false
    
    var body: some View {
        NavigationView {
            if exitSplashScreen {
                HomePage().environmentObject(fireDBHelper).environmentObject(locationHelper)
            } else {
                VStack {
                    Image(systemName: "app.fill")
                        .font(.system(size: 100))
                        .padding(.bottom, 20)
                    
                    Text("Your App Name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .font(.system(size: 100))
                        .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    exitSplashScreen = true
                                }
                            }
                        }
                }
                    .transition(.slide)
            }
        }
    }
}
