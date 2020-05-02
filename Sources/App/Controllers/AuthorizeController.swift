//
//  File.swift
//  
//
//  Created by Albus on 4/30/20.
//

import Fluent
import Vapor
import JWT


struct AuthorizeController {
    func login(req: Request) throws -> EventLoopFuture<HttpResult<User.LoginResult>> {
        var loginParams = try req.content.decode(LoginRequest.self)
        loginParams.code = "a5"
        return User.query(on: req.db).filter(\.$wx_open_id == loginParams.code).first().flatMap { u in
            
            let user: User = (u ?? User())
            user.wx_open_id = loginParams.code
            if (user.id == nil) {
                user.id = UUID()
            }
            
            let token = try? JWTSigner.hs256(key: .init(data: JWT_SIGN_SECRET.data(using: .utf8)!)).sign(UserToken(id: user.id!.uuidString))
            user.token = token
            
            return user.save(on: req.db).map {
//                let token = try? req.jwt.sign(UserToken(id: user.id!.uuidString))
//                let token = try? JWTSigner.es256(key: .generate()).sign(UserToken(id: user.id!.uuidString))
                let rst = User.LoginResult(token: token ?? "")
                return HttpResult<User.LoginResult>(successWith: rst)
            }
        }
    }
    
    func update_userinfo(req: Request) throws -> EventLoopFuture<HttpResult<User.Public>> {
        let params = try req.content.decode(UserInfoRequest.self);
        return User.query(on: req.db).filter(\.$wx_open_id == params.wx_open_id).first().flatMap { u in
            guard let user = u else {
                return req.eventLoop.future().map {
                    HttpResult(errorCode: 0, message: "用户错误")
                }
            }
            
            user.importData(from: params)
            return user.save(on: req.db).map {
                let rst = User.Public(avatarUrl: user.portrait_url, nickName: user.nickname, gender: user.gender, phoneNumber: user.phone_number, country: user.country, province: user.province, city: user.city, is_company: ((user.company_id != nil && user.company_id!.count > 0) ? true : false))
                return HttpResult(successWith: rst)
            }
        }
    }
}
