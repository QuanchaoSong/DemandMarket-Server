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
    
    
    func get_demand_type_list(req: Request) throws -> EventLoopFuture<HttpResult<[[String : String]]>> {
        return req.eventLoop.future().map { _ in
            HttpResult<[[String : String]]>(successWith: DEMAND_TYPE_LIST)
        }
    }
}
