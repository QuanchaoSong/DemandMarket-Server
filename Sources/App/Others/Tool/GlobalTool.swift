
//
//  File.swift
//  
//
//  Created by Albus on 5/1/20.
//

import Foundation

class GlobalTool : NSObject {
    static func routerName(version: String, group: String, name: String) -> String {
        let result = "\(version)/\(group)/\(name)"
        print("result: \(result)")
        return result
    }
    
    static func routerName(group: String, name: String) -> String {
        return self.routerName(version: VERSION, group: group, name: name)
    }
}
