//
//  PostItemPage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct PostItemPage: View {
    @State private var itemName = ""
    @State private var selectedDescription = "Please select" // Default selection

    private let descriptionOptions = ["Laptop", "Stationary", "Art Supplies", "Textbook"]

    private var dbHelper = FireDBHelper.getInstance()
    var body: some View {
        Form {
            Section(header: Text("Item Details")) {
                TextField("Item Name", text: $itemName)
                Picker("Description", selection: $selectedDescription) {
                                   ForEach(descriptionOptions, id: \.self) {
                                       Text($0)
                                   }
                               }
                Button("Submit") {
                    // Create an Item instance with the entered details
                    let newItem = Item(itemname: itemName, itemdesc: selectedDescription)

                    // Post the item to Firestore
                    dbHelper.insertItem(item: newItem)
                }
            }
        }
        .navigationBarTitle("Lend an Item")
    }
}

struct PostItemPage_Previews: PreviewProvider {
    static var previews: some View {
        PostItemPage()
    }
}
