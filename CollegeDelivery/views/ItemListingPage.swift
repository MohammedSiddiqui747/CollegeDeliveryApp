//
//  ItemListingPage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct ItemListingPage: View {
    @ObservedObject private var dbHelper = FireDBHelper.getInstance()
    @State private var searchText = ""

    var filteredItems: [Item] {
        dbHelper.itemList.filter { item in
            searchText.isEmpty || item.itemName.lowercased().contains(searchText.lowercased())
        }
    }

    var body: some View {
        NavigationView {
            List(filteredItems, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.itemName)
                        .font(.headline)
                    Text(item.itemDesc)
                        .font(.subheadline)
                    Text("Destination: \(item.itemLoc)") // Display the destination
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Posted Items")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                dbHelper.retrieveAllItems()
            }
        }
    }
}


struct ItemListingPage_Previews: PreviewProvider {
    static var previews: some View {
        ItemListingPage()
    }
}
