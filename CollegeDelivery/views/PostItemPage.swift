//
//  PostItemPage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct PostItemPage: View {
    @State private var userEmail = ""
    @State private var itemName = ""
    @State private var selectedDescription = "" // Empty default selection
    @State private var selectedLocation = "" // Empty default selection for destination
    @State private var showAlert = false
    @State private var alertMessage = ""

    private let descriptionOptions = ["Laptop", "Stationary", "Art Supplies", "Textbook", "Other"]
    private let destinationOptions = ["Trafalgar", "HMC", "Davis"] // Example destinations

    private var dbHelper = FireDBHelper.getInstance()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Enter User Email", text: $userEmail)
                    
                    TextField("Item Name", text: $itemName)
                    
                    Picker("Description", selection: $selectedDescription) {
                        Text("Please select").tag("") // Initial option for description
                        ForEach(descriptionOptions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Picker("Location", selection: $selectedLocation) {
                        Text("Please select").tag("") // Initial option for destination
                        ForEach(destinationOptions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    Button("Submit") {
                        if userEmail.isEmpty || itemName.isEmpty || selectedDescription.isEmpty || selectedLocation.isEmpty {
                            alertMessage = "Please fill in all fields."
                            showAlert = true
                        } else {
                            let newItem = Item(itemname: itemName, itemdesc: selectedDescription, itemloc: selectedLocation, useremail: userEmail) // Consider including the destination in your item model
                            dbHelper.insertItem(item: newItem)
                            alertMessage = "Item submitted successfully."
                            showAlert = true
                        }
                    }
                }
            }
            .navigationBarTitle("Lend an Item")
            .navigationBarItems(trailing: NavigationLink("Manage Items", destination: ManageItems()))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Submission Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct PostItemPage_Previews: PreviewProvider {
    static var previews: some View {
        PostItemPage()
    }
}
