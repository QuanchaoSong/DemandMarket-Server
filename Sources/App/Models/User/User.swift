//
//  File.swift
//  
//
//  Created by Albus on 4/30/20.
//

import Fluent
import Vapor
import JWT

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "wx_open_id")
    var wx_open_id: String?
    
    @Field(key: "gender")
    var gender: Int?
    
    @Field(key: "nickname")
    var nickname: String?
    
    @Field(key: "username")
    var username: String?
    
    @Field(key: "portrait_url")
    var portrait_url: String?
    
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
    
    @Field(key: "company_id")
    var company_id: String?
    
    @Field(key: "create_time")
    var create_time: Date?
    
    init() {
        self.portrait_url = ""
        self.nickname = ""
        self.username = ""
        self.gender = 0
        self.phone_number = ""
        self.birth_date = 0
        self.country = ""
        self.province = ""
        self.city = ""
        self.language = ""
        self.company_id = ""
        self.create_time = Date()
    }
    
    func importData(from params: UserInfoRequest) -> Void {
        self.portrait_url = params.avatarUrl
        self.nickname = params.nickName
        self.username = ""
        self.gender = params.gender
        self.phone_number = params.phoneNumber ?? ""
        self.country = params.country
        self.province = params.province
        self.city = params.city
        self.language = params.language
    }
}

extension User {
    struct LoginResult: Content {
        let token: String
    }
    
    struct Public: Content {
        var avatarUrl: String? = ""
        var nickName: String? = ""
        var gender: Int? = 0
        var phoneNumber: String? = ""
        var country: String? = ""
        var province: String? = ""
        var city: String? = ""
        var is_company: Bool? = false
    }
}

struct LoginRequest : Content {
    var code: String
}

struct UserInfoRequest : Content {
//    let wx_open_id: String
    let avatarUrl: String?
    let nickName: String?
    let gender: Int?
    let phoneNumber: String?
    let country: String?
    let province: String?
    let city: String?
    let language: String?
}



struct UserToken : JWTPayload  {
    var id: String! = ""
//    var create_time : Int! = Int(Date().timeIntervalSince1970);
//    var expired_duration: Int! = (5 * 24 * 60 * 60); // in second
//    
//    init(id: String?, create_time: Int?, expired_duration: Int?) {
//        self.id = id;
//        self.create_time = create_time;
//        self.expired_duration = expired_duration;
//    }
    
    init(id: String?) {
        self.id = id;
    }
        
    func verify(using signer: JWTSigner) throws {
        
    }
}
