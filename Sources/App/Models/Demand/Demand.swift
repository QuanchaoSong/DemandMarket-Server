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
    
    @Field(key: "content")
    var content: String?
    
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
        self.content = params.content ?? ""
        self.expiring_time = params.expiring_time ?? Int64(Date().timeIntervalSince1970)
        self.speciality = params.speciality ?? ""
        self.type = params.type ?? 0
    }
}

extension Demand {
    struct ListItem : Content {
        let the_id: Int?
        let title: String?
        let demander_name: String?
        let type_id: Int?
        let type_name: String?
        let status: Int?
        let status_name: String?
        let expiring_time: Int64?
        let expiring_time_string: String?
        let view_count: Int? = 0
    }
    
    struct Detail : Content {
        let publish_time_string: String?
        let expiring_time_string: String?
        let demander_name: String?
        let status: Int?
        let status_name: String?
        let specialities: String?
        let content: String?
    }
}


struct DemandDetailRequest : Content {
    let the_id: Int?
}

struct DemandCreationRequest : Content {
    let title: String?
    let content: String?
    let expiring_time: Int64?
    let speciality: String?
    let type: Int?
}


struct DemandListRequest : Content {
    // 需求分类
    let type_ids: String?
    // 发布时间
    let create_time_offset: Int64?
    // 需求状态
    let status: Int?
    // 省市
    let province: String?
    let city: String?
    
    
    
    var pageIndex: Int?
    var pageSize: Int?
    
    public lazy var rangeStart: Int! = {
        return (self.pageIndex ?? 0) * (self.pageSize ?? 20);
    }()
    
    public lazy var rangeEnd: Int! = {
        return ((self.pageIndex ?? 0) + 1) * (self.pageSize ?? 20);
    }()
}


struct TypeItem : Content {
    let type_id: Int?
    let title: String?
}
