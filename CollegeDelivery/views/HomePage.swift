//
//  HomePage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @EnvironmentObject var locationHelper: LocationHelper
    @Binding var rootView: RootView

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 100, maximum: 200)), GridItem(.flexible(minimum: 100, maximum: 200))], spacing: 16) {
                        NavigationLink(destination: ItemListingPage()) {
                            VStack(spacing: 8) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 54))
                                Text("Search for an Item")
                            }
                        } .buttonStyle(RoundedButtonStyle())
                        
                        NavigationLink(destination: PostItemPage()) {
                            VStack(spacing: 8) {
                                Image(systemName: "tray.and.arrow.up")
                                    .font(.system(size: 54))
                                Text("Post New Item")
                            }
                        } .buttonStyle(RoundedButtonStyle())
                        
                        NavigationLink(destination: RequestsManagementPage()) {
                            VStack(spacing: 8) {
                                Image(systemName: "tray.full.fill")
                                    .font(.system(size: 54))
                                Text("Requested Items")
                            }
                        } .buttonStyle(RoundedButtonStyle())

                        NavigationLink(destination: MapPage().environmentObject(locationHelper)) {
                            VStack(spacing: 8) {
                                Image(systemName: "map.fill")
                                    .font(.system(size: 54))
                                Text("Map")
                            }
                        } .buttonStyle(RoundedButtonStyle())
                    }
                    .padding()
                }

                Spacer()

                HStack {
                    Button("Sign Out") {
                        do {
                            try Auth.auth().signOut()
                            rootView = .prompt // Navigate back to the authentication view
                        } catch {
                            print("Error signing out: \(error.localizedDescription)")
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundColor(.white)

                    Spacer()
                }
                .padding()
            }
            .navigationTitle("College Delivery App")
        }
    }
}

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .aspectRatio(1.0, contentMode: .fit)
    }
}

struct MapButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .aspectRatio(2, contentMode: .fit)
    }
}
