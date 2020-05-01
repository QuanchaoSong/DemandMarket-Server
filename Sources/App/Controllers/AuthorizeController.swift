//
//  File.swift
//  
//
//  Created by Albus on 4/30/20.
//

import Fluent
import Vapor
import JWT

//struct Dss : ContiguousBytes {
//    func withUnsafeBytes<R>(_ body: (UnsafeRawBufferPointer) throws -> R) rethrows -> R {
//
//    }
//
//    let secret: String
//}

struct AuthorizeController {
    func login(req: Request) throws -> EventLoopFuture<HttpResult<User.LoginResult>> {
        let loginParams = try req.content.decode(LoginRequest.self)
        return User.query(on: req.db).filter(\.$wx_open_id == loginParams.code).first().flatMap { u in
            
            let user: User = (u ?? User())
            user.wx_open_id = loginParams.code
            if (user.id == nil) {
                user.id = UUID()
            }
            
            return user.save(on: req.db).map {
//                let token = try? req.jwt.sign(UserToken(id: user.id!.uuidString))
                let token = try? JWTSigner.es256(key: .generate()).sign(UserToken(id: user.id!.uuidString))
//                let tmpData:
//                let token = try? JWTSigner.hs256(key: .init(data: "hldls_de8dc_8e2".data(using: .utf8))).sign(UserToken(id: user.id!.uuidString))
                let rst = User.LoginResult(token: token ?? "")
                return HttpResult<User.LoginResult>(successWith: rst)
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
