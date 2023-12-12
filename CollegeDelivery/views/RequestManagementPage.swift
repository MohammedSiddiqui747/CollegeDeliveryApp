//
//  RequestManagementPage.swift
//  CollegeDelivery
//
//  Created by Mohammed Siddiqui on 2023-11-29.
//

import SwiftUI



struct RequestsManagementPage: View {
    @ObservedObject private var dbHelper = FireDBHelper.getInstance()
    
    

    
    var body: some View {
        NavigationView {
            List(dbHelper.reqItemList, id: \.id){ item in
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
        .onAppear{
            dbHelper.retrieveAllReqItems()
        }
    }
}

//struct RequestsManagementPage_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestsManagementPage()
//    }
//}
