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
}
