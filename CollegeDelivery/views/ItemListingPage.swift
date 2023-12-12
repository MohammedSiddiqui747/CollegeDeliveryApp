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
    @State private var isShowingPopup = false
    @State private var reqEmail = ""
    @State private var reqItemName = ""
    @State private var reqItemDesc = ""
    @State private var reqItemLoc = ""


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
                    Button(action: {
                        isShowingPopup.toggle()
                        reqItemName = item.itemName
                        reqItemDesc = item.itemDesc
                        reqItemLoc = item.itemLoc
                                }) {
                                    Text("Request Item")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                    
                    
//                        .onTapGesture{
//                            dbHelper.createItem(itemName: item.itemName)
//                            isAddReqItemViewPresented = true
//                        }
//                    NavigationLink (destination: AddReqItemView().environmentObject(dbHelper), isActive: $isAddReqItemViewPresented, label: { Text("Request Item")})
                }
                
                
                
            }
            .navigationBarTitle("Posted Items")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                dbHelper.retrieveAllItems()
            }
            
            
        }
        if isShowingPopup {
            ZStack {
                VStack {
                    Text("Enter your email address to place order:")
                                                .padding()
                    TextField("Enter email:", text : self.$reqEmail)
                        .padding()

                    Button(action: {
                        let newItem = Item(itemname: reqItemName, itemdesc: reqItemDesc, itemloc: reqItemLoc, useremail: reqEmail) // Consider including the destination in your item model
                        dbHelper.insertReqItem(item: newItem)
                        isShowingPopup.toggle()
                            }) {
                            Text("Request and Close")
                                    .padding()
                            }
                }
            }
        }
    }
}


struct ItemListingPage_Previews: PreviewProvider {
    static var previews: some View {
        ItemListingPage()
    }
}
