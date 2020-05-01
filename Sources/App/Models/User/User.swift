//
//  File.swift
//  
//
//  Created by Albus on 4/30/20.
//

import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "wx_open_id")
    var wx_open_id: String?
    
    @Field(key: "gender")
    var gender: UInt8?
    
    @Field(key: "nickname")
    var nickname: String?
    
    @Field(key: "username")
    var username: String?
    
    @Field(key: "phone_number")
    var phone_number: String?
    
    @Field(key: "token")
    var token: String?
    
    @Field(key: "birth_date")
    var birth_date: UInt64?
    
    @Field(key: "country")
    var country: String?
    
    @Field(key: "province")
    var province: String?
    
    @Field(key: "city")
    var city: String?
    
    @Field(key: "language")
    var language: String?
    
    @Field(key: "firm_id")
    var firm_id: String?
    
    @Field(key: "create_time")
    var create_time: Date?
    
    
//    init(from loginRequest: LoginRequest) {
//        self.wx_open_id = loginRequest.wx_open_id
//        
//    }
}

extension User {
    struct LoginResult: Content {
        let token: String
    }
    
    struct Public: Content {
        let nickname: String
    }
}

struct LoginRequest : Content {
    let code: String
}

struct UserInfoRequest : Content {
    let wx_open_id: String
    let avatarUrl: String
    let nickName: String
    let gender: UInt8
    let phone_number: String
    let country: String
    let province: String
    let city: String
    let language: String
}
