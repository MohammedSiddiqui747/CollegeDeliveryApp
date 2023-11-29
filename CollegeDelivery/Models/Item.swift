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

    
    init(){
        self.itemName = "NA"
        self.itemDesc = "NA"

        
    }
    
    init(itemname: String, itemdesc: String) {
        

        self.itemName = itemname
        self.itemDesc = itemdesc
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
        
        self.init(itemname: itemName, itemdesc: itemDesc)
        
    }
}
