//
//  File.swift
//  
//
//  Created by Albus on 5/2/20.
//

import Fluent
import Vapor

struct DemandController {
    func create_demand(req: Request) throws -> EventLoopFuture<HttpResult<Demand>> {
        let uuid = UUID(uuidString: "634d4cbf-b451-4eff-a8dd-c9b9becb3c23")
        let params = try req.content.decode(DemandCreationRequest.self)
        return User.find(uuid!, on: req.db).flatMap { user in
            let dmd = Demand()
            dmd.importData(from: params)
            dmd.demander_id = user!.id!.uuidString
            dmd.wx_open_id = user!.wx_open_id
            dmd.demander_name = user!.nickname
            return dmd.create(on: req.db).flatMap { d in
                return req.eventLoop.future().map {
                    HttpResult<Demand>(successWithMessage: "创建成功")
                }
            }
        }
    }
    
    func get_demand_list(req: Request) throws -> EventLoopFuture<HttpResult<[Demand.ListItem]>> {
//        let params = try req.content.decode(PageIndexRequest.self)
        return Demand.query(on: req.db).all().map { demands in
            let result = demands.compactMap {
                Demand.ListItem(title: $0.title)
            }
            return HttpResult<[Demand.ListItem]>(successWith: result)
//            var result = [Demand.ListItem]()
//            for demand in demands {
//                let item =  Demand.ListItem(title: demand.title)
//                result.append(item)
//            }
//            return HttpResult<[Demand.ListItem]>(successWith: result)
        }
    }
    
    
    func get_demand_type_list(req: Request) throws -> EventLoopFuture<HttpResult<[[String : String]]>> {
        return req.eventLoop.future().map { _ in
            HttpResult<[[String : String]]>(successWith: DEMAND_TYPE_LIST)
        }
    }
}
