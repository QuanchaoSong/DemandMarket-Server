//
//  File.swift
//  
//
//  Created by Albus on 5/7/20.
//

import Foundation
import Alamofire

class HttpDigger {
    class func shared() -> HttpDigger {
        return sharedInstance
    }
    
    private static let sharedInstance: HttpDigger = {
        let shared = HttpDigger()
        return shared
    }()
    
    private init() {
        self.headers = [
            "User-Agent": "Demand Market Server",
            "Accept": "application/json"
        ]
    }
    
    
    let networkMgr = AF
    var headers: HTTPHeaders
    
    typealias SuccessBlock = (_ responseJson: Dictionary<String, Any>) -> Void
    typealias FailureBlock = (_ err: Error) -> Void
    
    func get(url: String?, parameters: Dictionary<String, Any>?, success: SuccessBlock, failure: FailureBlock) -> Void {
        guard let urlString = url else {
            return
        }
        
        self.networkMgr.request(URL(string: urlString)!, method: .get, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
            switch response.result {
            case .success(let json):
                print("fsfalsfasl: \(json)")
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
    
    func post(url: String?, parameters: Dictionary<String, Any>?, success: SuccessBlock, failure: FailureBlock) -> Void {
        guard let urlString = url else {
            return
        }
        
        //        var mDict = Dictionary<String, Any>()
        //        if (parameters != nil) {
        //            mDict.merging(parameters) { $0 }
        //        }
        
        self.networkMgr.request(URL(string: urlString)!, method: .post, parameters: parameters, headers: self.headers).responseJSON { response in
            print("responseresponse: \(response)");
        }
    }
}
