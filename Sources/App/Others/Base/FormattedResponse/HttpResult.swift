//
//  File.swift
//  
//
//  Created by Albus on 5/1/20.
//

import Foundation
import Vapor

struct HttpResult<T : Content> : Content {
    var code: Int
    var data: T?
    var message: String
    
    init(code: Int? = 1, data: T? = nil, message: String? = "success") {
        self.code = code!
        self.data = data
        self.message = message!
    }
    
    init(successWithMessage message: String, data: T) {
        self.code = 1
        self.message = message
        self.data = data
    }
    
    init(successWithMessage message: String) {
        self.code = 1
        self.message = message
        self.data = ("" as! T)
    }
    
    init(successWith data: T? = nil) {
        self.code = 1
        self.message = "success"
        self.data = data
    }
    
    init(errorCode: Int, message: String) {
        self.code = errorCode
        self.message = message
        self.data = ("" as! T)
    }
    
    static func invalidToken() -> HttpResult<String> {
        return HttpResult<String>(errorCode: 10001, message: "Invalid Token");
    }
}
