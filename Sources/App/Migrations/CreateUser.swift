//
//  File.swift
//  
//
//  Created by Albus on 5/1/20.
//

import Fluent

struct CreateUser : Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").id()
            .field("wx_open_id", .string, .required)
            .field("gender", .uint8, .required)
            .field("nickname", .string, .required)
            .field("username", .string, .required)
            .field("phone_number", .string, .required)
            .field("token", .string, .required)
            .field("birth_date", .uint64, .required)
            .field("country", .string, .required)
            .field("province", .string, .required)
            .field("city", .string, .required)
            .field("language", .string, .required)
            .field("firm_id", .string, .required)
            .field("create_time", .datetime, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
