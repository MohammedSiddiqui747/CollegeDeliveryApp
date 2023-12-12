//
//  Item.swift
//  CollegeDeliveryWidgetExtension
//
//  Created by Paolo Veloso on 2023-12-11.
//

import Foundation

struct Item: Codable, Identifiable, Hashable {
    let id: String  // Use a non-optional String for the widget
    let itemName: String
    let itemDesc: String
    let itemLoc: String

    // Since we don't use @DocumentID and FirestoreSwift in the widget,
    // the 'id' is a regular String and should be provided when creating an instance.

    // The initializer can be simplified as Firestore-specific code is not needed
    init(id: String = UUID().uuidString, itemName: String = "NA", itemDesc: String = "NA", itemLoc: String = "NA") {
        self.id = id
        self.itemName = itemName
        self.itemDesc = itemDesc
        self.itemLoc = itemLoc
    }


    // Example static data for placeholder and testing
    static let example = Item(id: "1", itemName: "Sample Item", itemDesc: "Sample Description", itemLoc: "")

}

