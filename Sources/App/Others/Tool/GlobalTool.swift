//
//  File.swift
//  
//
//  Created by Albus on 5/1/20.
//

import Foundation
import Vapor
import JWT

class GlobalTool: NSObject {
    static func formattedDate(by timestamp: Int64?, formatString: String? = "yyyy-MM-dd") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: timestamp ?? 0))
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = formatString ?? "yyyy-MM-dd"
        return dateFmt.string(from: date)
    }
    
    static func routerName(version: String, group: String, name: String) -> [PathComponent] {
        let result = "\(version)/\(group)/\(name)"
        return result.pathComponents
    }
    
    static func routerName(group: String, name: String) -> [PathComponent] {
        return self.routerName(version: VERSION, group: group, name: name)
    }
}
