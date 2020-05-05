//
//  File.swift
//  
//
//  Created by Albus on 5/2/20.
//

import Fluent
import Vapor
import PostgresKit

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
        var params = try req.content.decode(DemandListRequest.self)
        let sqlString = String(format: "SELECT * FROM public.demands LIMIT %d OFFSET %d;", (params.rangeEnd - params.rangeStart), params.rangeStart)
        let sql = (req.db as! PostgresDatabase).sql()
        return sql.raw(SQLQueryString(stringLiteral: sqlString)).all().map { rows in
            let result = rows.compactMap { row -> Demand.ListItem in
                let sqlRow = (row as SQLRow)
                
                let demand = try! sqlRow.decode(model: Demand.self)
                
                return Demand.ListItem(title: demand.title, demander_name: demand.demander_name, type_id: demand.type, type_name: getTypeNameBy(typeId: demand.type!), status: demand.status, expiring_time: demand.expiring_time)
            }
            
            return HttpResult<[Demand.ListItem]>(successWith: result)
        }
    }
    
    
    func get_my_demand_list(req: Request) throws -> EventLoopFuture<HttpResult<[Demand.ListItem]>> {
        var params = try req.content.decode(PageIndexRequest.self)
        let user_id = "634D4CBF-B451-4EFF-A8DD-C9B9BECB3C23"
        let sqlString = String(format: "SELECT * FROM public.demands WHERE demander_id = '%@' LIMIT %d OFFSET %d;", user_id, (params.rangeEnd - params.rangeStart), params.rangeStart)
        let sql = (req.db as! PostgresDatabase).sql()
        return sql.raw(SQLQueryString(stringLiteral: sqlString)).all().map { rows in
            let result = rows.compactMap { row -> Demand.ListItem in
                let sqlRow = (row as SQLRow)
                
                let demand = try! sqlRow.decode(model: Demand.self)
                
                return Demand.ListItem(title: demand.title, demander_name: demand.demander_name, type_id: demand.type, type_name: getTypeNameBy(typeId: demand.type!), status: demand.status, expiring_time: demand.expiring_time)
            }
            
            return HttpResult<[Demand.ListItem]>(successWith: result)
        }
    }
    
    
    func get_demand_type_list(req: Request) throws -> EventLoopFuture<HttpResult<[[String : String]]>> {
        return req.eventLoop.future().map { _ in
            HttpResult<[[String : String]]>(successWith: DEMAND_TYPE_LIST)
        }
    }
}
