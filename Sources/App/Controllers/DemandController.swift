//
//  File.swift
//  
//
//  Created by Albus on 5/2/20.
//

import Fluent
import Vapor

struct DemandController {
//    func create_demand(req: Request) throws -> EventLoopFuture<HttpResult<Demand>> {
//
//    }
    
    
    func get_demand_type_list(req: Request) throws -> EventLoopFuture<HttpResult<[TypeItem]>> {
        var result = [TypeItem]()
        let item1 = TypeItem(type_id: 0, title: "自定义")
        let item2 = TypeItem(type_id: 1, title: "产品设计")
        result.append(item1)
        result.append(item2)
        return req.eventLoop.future().map { _ in
            HttpResult<[TypeItem]>(successWith: result)
        }
    }
}
