//
//  ItemListingPage.swift
//  CollegeDelivery
//
//  Created by Paolo Veloso on 2023-11-29.
//

import SwiftUI

struct ItemListingPage: View {
    @ObservedObject private var dbHelper = FireDBHelper.getInstance()

       var body: some View {
           NavigationView {
               List(dbHelper.itemList, id: \.id) { item in
                   VStack(alignment: .leading) {
                       Text(item.itemName)
                           .font(.headline)
                       Text(item.itemDesc)
                           .font(.subheadline)
                   }
               }
               .navigationBarTitle("Posted Items")
           }
           .onAppear {
               dbHelper.retrieveAllItems()
           }
       }
   }
struct ItemListingPage_Previews: PreviewProvider {
    static var previews: some View {
        ItemListingPage()
    }
}
