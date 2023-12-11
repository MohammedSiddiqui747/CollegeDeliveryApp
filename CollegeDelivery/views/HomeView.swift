//
//  HomeView.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-12-11.
//

import SwiftUI

struct HomeView: View {
    @State private var rootView: RootView = .prompt // Changed to .prompt
    let fireDBHelper: FireDBHelper = FireDBHelper.getInstance()

    var body: some View {
        NavigationStack {
            switch rootView {
            case .prompt:
                AuthView(rootView: $rootView)
            case .login:
                SignInView(rootView: $rootView)
            case.signup:
                SignUpView(rootView: $rootView)
            case .main:
                HomePage(rootView: $rootView).environmentObject(fireDBHelper)
            // Add case for .signup if you have a separate signup view
            }
        }
    }
}
#Preview {
    HomeView()
}
