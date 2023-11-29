//
//  HomePage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Spacer()
                
                NavigationLink(destination: ItemListingPage()) {
                    Text("Search for an Item")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: PostItemPage()) {
                    Text("Lend an Item")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: RequestsManagementPage()) {
                    Text("My Requests")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarTitle("Home")
        }
    }
}
