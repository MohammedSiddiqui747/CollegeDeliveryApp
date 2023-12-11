//
//  PostItemPage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct PostItemPage: View {
    @State private var itemName = ""
    @State private var selectedDescription = "" // Empty default selection
    @State private var showAlert = false
    @State private var alertMessage = ""

    private let descriptionOptions = ["Laptop", "Stationary", "Art Supplies", "Textbook"]

    private var dbHelper = FireDBHelper.getInstance()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item Name", text: $itemName)
                    
                    Picker("Description", selection: $selectedDescription) {
                        Text("Please select").tag("") // Initial option
                        ForEach(descriptionOptions, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(MenuPickerStyle()) // You can choose the style you prefer

                    Button("Submit") {
                        if itemName.isEmpty || selectedDescription.isEmpty {
                            alertMessage = "Please fill in all fields."
                            showAlert = true
                        } else {
                            let newItem = Item(itemname: itemName, itemdesc: selectedDescription)
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
