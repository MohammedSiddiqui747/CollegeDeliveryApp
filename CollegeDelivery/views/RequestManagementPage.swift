//
//  RequestManagementPage.swift
//  CollegeDelivery
//
//  Created by Mohammed Siddiqui on 2023-11-29.
//

import SwiftUI



struct RequestsManagementPage: View {
    @ObservedObject private var dbHelper = FireDBHelper.getInstance()
    
    
    @State private var reqUserEmail = ""
    
    var filteredItems: [Item] {
        dbHelper.reqItemList.filter { item in
            item.userEmail == reqUserEmail
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Please Enter your email: ", text: $reqUserEmail)
                    .padding()
                Button(action: {
                    dbHelper.retrieveAllReqItems()
                }) {
                    Text("Show Requested Items")
                        .padding()
                }
                .padding()
                List(filteredItems, id: \.id) { item in
                    VStack(alignment: .leading) {
                        Text(item.itemName)
                            .font(.headline)
                        Text(item.itemDesc)
                            .font(.subheadline)
                        Text("Destination: \(item.itemLoc)") // Display the destination
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Button(action: {
                            if let id = item.id {
                                dbHelper.deleteReqItem(docIDtoDelete: id)
                                
                            }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            
        }
    }
}
