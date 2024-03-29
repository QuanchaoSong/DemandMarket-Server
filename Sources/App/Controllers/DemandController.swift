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
        let uuid = UUID(uuidString: "b970dc2c-3c1d-4510-ab9d-d47e38877c65")
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
    
    func get_demand_detail(req: Request) throws -> EventLoopFuture<HttpResult<Demand.Detail>> {
        let params = try req.content.decode(DemandDetailRequest.self)
        return Demand.find(params.the_id, on: req.db).map({ d in
            guard let dmd = d else {
                return HttpResult<Demand.Detail>(errorWithMessage: "无数据")
            }
            
            let detail = Demand.Detail(publish_time_string: GlobalTool.formattedDate(by: Int64(dmd.create_time!.timeIntervalSince1970)), expiring_time_string: GlobalTool.formattedDate(by: dmd.expiring_time), demander_name: dmd.demander_name, status: dmd.status, status_name: "对接中", specialities: "汽车、奢侈品", content: dmd.content)
            return HttpResult<Demand.Detail>(successWith: detail)
        })
    }
    
    func get_demand_list(req: Request) throws -> EventLoopFuture<HttpResult<[Demand.ListItem]>> {
        var params = try req.content.decode(DemandListRequest.self)
        let sqlString = String(format: "SELECT * FROM public.demands LIMIT %d OFFSET %d;", (params.rangeEnd - params.rangeStart), params.rangeStart)
        let sql = (req.db as! PostgresDatabase).sql()
        return sql.raw(SQLQueryString(stringLiteral: sqlString)).all().map { rows in
            let result = rows.compactMap { row -> Demand.ListItem in
                let sqlRow = (row as SQLRow)
                
                let demand = try! sqlRow.decode(model: Demand.self)
                
                return Demand.ListItem(the_id: demand.id, title: demand.title, demander_name: demand.demander_name, type_id: demand.type, type_name: getTypeNameBy(typeId: demand.type!), status: demand.status, status_name: self.getStatusNameBy(status: demand.status), expiring_time: demand.expiring_time, expiring_time_string: GlobalTool.formattedDate(by: demand.expiring_time))
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
                
                return Demand.ListItem(the_id: demand.id, title: demand.title, demander_name: demand.demander_name, type_id: demand.type, type_name: getTypeNameBy(typeId: demand.type!), status: demand.status, status_name: self.getStatusNameBy(status: demand.status), expiring_time: demand.expiring_time, expiring_time_string: GlobalTool.formattedDate(by: demand.expiring_time))
            }
            
            return HttpResult<[Demand.ListItem]>(successWith: result)
        }
    }
    
    
    func get_demand_type_list(req: Request) throws -> EventLoopFuture<HttpResult<[[String : String]]>> {
        return req.eventLoop.future().map { _ in
            HttpResult<[[String : String]]>(successWith: DEMAND_TYPE_LIST)
        }
    }
    
    
    private func getStatusNameBy(status: Int? = 0) -> String {
        var result : String = ""
        if (status == 0) {
            result = "审核中"
        } else if (status == 1) {
            result = "审核通过"
        } else if (status == 2) {
            result = "被拒绝"
        }
        
        return result
    }
}
