//
//  File.swift
//  
//
//  Created by Albus on 4/30/20.
//

import Fluent
import Vapor

struct AuthorizeController {
    func login(req: Request) throws -> EventLoopFuture<User.Public> {
        let loginParams = try req.content.decode(LoginRequest.self);
        return User.query(on: req.db).filter(\.$wx_open_id == loginParams.wx_open_id).first().unwrap(or: Abort(.notFound)).map { _ in
            return User.Public(token: "sdfa");
        }
    }
}
