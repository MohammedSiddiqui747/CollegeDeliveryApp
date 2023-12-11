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
            .background(Color.green)
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
