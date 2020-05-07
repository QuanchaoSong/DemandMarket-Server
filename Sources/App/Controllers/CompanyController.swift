//
//  File.swift
//  
//
//  Created by Albus on 5/5/20.
//

import Fluent
import Vapor

struct CompanyController {
    func get_company_speciality_list(req: Request) throws -> EventLoopFuture<HttpResult<[[String : String]]>> {
        return req.eventLoop.future().map {
            HttpResult<[[String : String]]>(successWith: COMPANY_SPECIALITY_LIST)
        }
    }
    
    func create_company(req: Request) throws -> EventLoopFuture<HttpResult<String>> {
        let params = try req.content.decode(CompanyCreationRequest.self);
        
        let c = Company()
        c.importData(from: params)
        return c.create(on: req.db).flatMap { _ in
            return req.eventLoop.future().map {
                HttpResult<String>()
            }
        }
    }
}
