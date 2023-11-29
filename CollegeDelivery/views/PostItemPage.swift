//
//  PostItemPage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct PostItemPage: View {
    @State private var itemName = ""
    @State private var itemDescription = ""

    var body: some View {
        Form {
            Section(header: Text("Item Details")) {
                TextField("Item Name", text: $itemName)
                TextField("Description", text: $itemDescription)
                Button("Submit") {
                    // Handle the submit action
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
