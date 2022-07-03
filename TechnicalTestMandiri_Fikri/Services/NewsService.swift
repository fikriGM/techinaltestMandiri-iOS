//
//  NewsService.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import ObjectMapper

class NewsService {
    static let shared = { NewsService() } ()
    
    func getNews(success: @escaping (Int, NewsModule) -> (),
                 failure: @escaping (Int, ErrorModule) -> (), errors: @escaping (String) -> ()) {
        let urlString = self.configurationAPICall(EndPoints.EVERYTHING, "apiKey", "89142a5c40d642bea88f0b6324abf451")
        APIClient.shared.getObjects(urlString: urlString, success: { (statusCode, objecOfNews) in
            success(statusCode, objecOfNews)
        }, failure: {(errorCode, objectErrorOfNews) in
            failure(errorCode, objectErrorOfNews)
        }, errors: { (stringMessage) in
            errors(stringMessage)
        })
    }
    
    func configurationAPICall(_ baseUrl: String, _ parameters: String, _ value: String) -> String {
        return  baseUrl + "?q=apple&from=2022-06-30&to=2022-07-01&sortBy=popularity&" + parameters + "=" + value
    }
}
