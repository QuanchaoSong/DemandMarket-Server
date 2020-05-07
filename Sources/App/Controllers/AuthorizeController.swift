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
        let loginParams = try req.content.decode(LoginRequest.self)
        
        let urlString = String(format: "https://api.weixin.qq.com/sns/jscode2session?grant_type=authorization_code&appid=%@&secret=%@&js_code=%@", WX_APP_ID, WX_APP_SECRET, loginParams.code)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        var wx_open_id: String = ""
        let dataTask = URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) -> Void in
            if (error != nil) {
                print("\(String(describing: error))")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
            wx_open_id = (json?["openid"]! ?? "") as! String
            
            semaphore.signal()
        }
        dataTask.resume()
        
        semaphore.wait()
        
        print("wx_open_id: \(wx_open_id)")
        
        guard (wx_open_id.count > 0) else {
            return req.eventLoop.future().map {
                HttpResult<User.LoginResult>(errorWithMessage: "code无效")
            }
        }
        
        return User.query(on: req.db).filter(\.$wx_open_id == wx_open_id).first().flatMap { u in
            
            let user: User = (u ?? User())
            user.wx_open_id = wx_open_id
            if (user.id == nil) {
                user.id = UUID()
            }
            
            let token = try? JWTSigner.hs256(key: .init(data: JWT_SIGN_SECRET.data(using: .utf8)!)).sign(UserToken(id: user.id!.uuidString))
            user.token = token
            
            return user.save(on: req.db).map {
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
