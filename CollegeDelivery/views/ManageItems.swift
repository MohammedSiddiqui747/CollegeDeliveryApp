//
//  ManageItems.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-12-11.
//

import SwiftUI

struct ManageItems: View {
    @ObservedObject private var dbHelper = FireDBHelper.getInstance()

    var body: some View {
        NavigationView {
            List {
                ForEach(dbHelper.itemList, id: \.id) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.itemName)
                                .font(.headline)
                            Text(item.itemDesc)
                                .font(.subheadline)
                        }
                        Spacer()
                        Button(action: {
                            if let id = item.id {
                                dbHelper.deleteItem(docIDtoDelete: id)
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationBarTitle("Manage Items")
        }
        .onAppear {
            dbHelper.retrieveAllItems()
        }
    }
}

#Preview {
    ManageItems()
}
