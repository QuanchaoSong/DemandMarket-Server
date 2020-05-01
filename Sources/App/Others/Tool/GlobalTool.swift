//
//  File.swift
//  
//
//  Created by Albus on 5/1/20.
//

import Foundation
import Vapor

class GlobalTool: NSObject {
    static func routerName(version: String, group: String, name: String) -> [PathComponent] {
        let result = "\(version)/\(group)/\(name)"
        return result.pathComponents
    }
    
    static func routerName(group: String, name: String) -> [PathComponent] {
        return self.routerName(version: VERSION, group: group, name: name)
    }
}
