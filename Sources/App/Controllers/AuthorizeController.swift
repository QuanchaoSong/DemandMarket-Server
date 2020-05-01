//
//  File.swift
//  
//
//  Created by Albus on 4/30/20.
//

import Fluent
import Vapor

struct AuthorizeController {
    func login(req: Request) throws -> EventLoopFuture<User.LoginResult> {
        let loginParams = try req.content.decode(LoginRequest.self)
        return User.query(on: req.db).filter(\.$wx_open_id == loginParams.code).first().flatMap { u in
            let user: User = (u ?? User())
            user.wx_open_id = loginParams.code
            return user.save(on: req.db).map {
                User.LoginResult(token: "hahadlfjasdfldsf")
            }
        }
    }
    
//    func update_userinfo(req: Request) throws -> EventLoopFuture<User.Public> {
//        let loginParams = try req.content.decode(LoginRequest.self);
//        return User.query(on: req.db).filter(\.$wx_open_id == loginParams.wx_open_id).first().flatMap { u in
//            let user: User = u ?? User()
//            user.wx_open_id = loginParams.wx_open_id
//            user.nickname = loginParams.nickname
//            user.gender = loginParams.gender
//            return user.save(on: req.db).map {
//                User.Public(nickname: "dksslfs")
//            }
//        }
//    }
}
