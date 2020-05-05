//
//  File.swift
//  
//
//  Created by Albus on 5/3/20.
//

import Fluent
import Vapor

struct PageIndexRequest : Content {
    var pageIndex: Int?
    var pageSize: Int?
    
    init() {
        self.pageIndex = 10
        self.pageSize = 20
    }
    
    public lazy var rangeStart: Int! = {
        return (self.pageIndex ?? 0) * (self.pageSize ?? 20);
    }()
    
    public lazy var rangeEnd: Int! = {
        return ((self.pageIndex ?? 0) + 1) * (self.pageSize ?? 20);
    }()
}
