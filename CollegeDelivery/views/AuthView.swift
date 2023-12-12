//
//  AuthView.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-12-11.
//

import SwiftUI

struct AuthView: View {
    @Binding var rootView: RootView

    var body: some View {
        VStack {
            Image("download")
            .resizable()         // Make the image resizable
            .scaledToFit()       // Ensure the image fits the available space
            .frame(height: 200)  // Set the height of the image frame (adjust as needed)
            .padding(.bottom)    // Add some padding below the image

            Button("Log In") {
                rootView = .login
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Button("Sign Up") {
                rootView = .signup // Assuming you have a signup view case in RootView
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
    
}
/*
#Preview {
    AuthView()
} */
