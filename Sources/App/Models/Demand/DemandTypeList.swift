//
//  File.swift
//  
//
//  Created by Albus on 5/2/20.
//

import Foundation

let DEMAND_TYPE_LIST : [[String : String]] = [
    ["type_id":"1", "title":"产品设计"],
    ["type_id":"2", "title":"工业设计"],
    ["type_id":"0", "title":"自定义"],
]

func getTypeNameBy(typeId : Int) -> String {
    let typeIdString = String(typeId)
    for typeItem in DEMAND_TYPE_LIST {
        if ((typeItem["type_id"]!) == typeIdString) {
            return typeItem["title"]!
        }
    }
    
    return ""
}
