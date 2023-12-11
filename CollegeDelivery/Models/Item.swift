//
//  Item.swift
//  CollegeDelivery
//
//  Created by Mohammed Siddiqui.
//



import Foundation
import FirebaseFirestoreSwift

//model

struct Item : Codable, Hashable{
    
    @DocumentID var id : String? = UUID().uuidString
    
    var itemName : String = ""
    var itemDesc : String = ""
    var itemLoc : String = ""

    
    init(){
        self.itemName = "NA"
        self.itemDesc = "NA"
        self.itemLoc = "NA"

        
    }
    
    init(itemname: String, itemdesc: String, itemloc: String) {
        

        self.itemName = itemname
        self.itemDesc = itemdesc
        self.itemLoc = itemloc
    }
    
    //JSON object to Swift Object
    
//    //failable initializer
    init?(dictionary: [String: Any]){
        
        guard let itemName = dictionary["itemName"] as? String else{
            return nil
        }
        
        guard let itemDesc = dictionary["itemDesc"] as? String else{
            return nil
        }
        
        guard let itemLoc = dictionary["itemLoc"] as? String else{
            return nil
        }
        
        self.init(itemname: itemName, itemdesc: itemDesc, itemloc: itemLoc)
        
    }
}
