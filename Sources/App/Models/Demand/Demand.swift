//
//  File.swift
//  
//
//  Created by Albus on 5/2/20.
//

import Fluent
import Vapor


final class Demand: Model, Content {
    static let schema = "demands"
    
    @ID(custom: "id", generatedBy: .database)
    var id: Int?
    
    @Field(key: "wx_open_id")
    var wx_open_id: String?
    
    @Field(key: "title")
    var title: String?
    
    @Field(key: "demander_name")
    var demander_name: String?
    
    @Field(key: "desc")
    var desc: String?
    
    @Field(key: "expiring_time")
    var expiring_time: Int64?
    
    @Field(key: "speciality")
    var speciality: String?
    
    @Field(key: "status")
    var status: Int?
    
    @Field(key: "type")
    var type: Int?
    
    @Field(key: "demander_id")
    var demander_id: String?
    
    @Field(key: "create_time")
    var create_time: Date?
    
    
    init() {
    }
    
    
    func importData(from params: DemandCreationRequest) -> Void {
        self.title = params.title ?? ""
        self.desc = params.desc ?? ""
        self.expiring_time = params.expiring_time ?? Int64(Date().timeIntervalSince1970)
        self.speciality = params.speciality ?? ""
        self.type = params.type ?? 0
    }
}

extension Demand {
    struct ListItem : Content {
        let title: String?
        let demander_name: String?
        let type_id: Int?
        let type_name: String?
        let status: Int?
        let expiring_time: Int64?
        let view_count: Int? = 0
    }
}


struct DemandCreationRequest : Content {
    let title: String?
    let desc: String?
    let expiring_time: Int64?
    let speciality: String?
    let type: Int?
}




struct TypeItem : Content {
    let type_id: Int?
    let title: String?
}
