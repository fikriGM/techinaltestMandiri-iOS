//
//  APIClient.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import UIKit

class APIClient {
    var baseUrl : URL?
    
    static let shared = { APIClient(baseUrl: APIManager.shared.urldecider) } ()
    
    required init(baseUrl: String) {
        self.baseUrl = URL(string: baseUrl)
    }
    
    func getObjects<T, X>(urlString: String,
                          success: @escaping (Int, T) -> (),
                          failure: @escaping (Int, X) -> (),
                          errors: @escaping (String) -> ()) where T: BaseMappable, X: BaseMappable  {
        
        let headers : HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        guard let url = NSURL(string: urlString, relativeTo: self.baseUrl as URL?) else {
            return
        }
        
        let urlString = url.absoluteString!
        print("urlString: \(urlString)")
        Alamofire.request(urlString,
                          method: .get,
                          encoding: JSONEncoding.default,
                          headers: headers)
        .responseObject { (dataResponse: DataResponse<T>) in
            let response = dataResponse.result.value
            switch dataResponse.response!.statusCode {
            case 200, 201:
                let res = response?.toJSON()
                let data = Mapper<NewsModule>().map(JSON: res!)
                if data?.totalResults == 0 {
                    errors("Data empty")
                }else {
                    success(dataResponse.response!.statusCode, response as! T)
                }
            default:
                let res = response?.toJSONString()
                let errorMapper = Mapper<ErrorModule>().map(JSONString: res!)
                failure(dataResponse.response!.statusCode, errorMapper as! X)
                
            }
            
        }
        
    }
}

