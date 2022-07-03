//
//  SourceService.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import ObjectMapper

class SourceService {
    static let shared = { SourceService() } ()
    
    func getSource(source: String, success: @escaping (Int, NewsModule) -> (),
                   failure: @escaping (Int, ErrorModule) -> (),
                   errors: @escaping (String) -> ()) {
        let urlString = self.configurationAPICall(EndPoints.TOP_HEADLINES, "sources", source)
        APIClient.shared.getObjects(urlString: urlString, success: { (code, objectOfSource) in
            success(code, objectOfSource)
        }, failure: { (code, errorMessage) in
            failure(code, errorMessage)
        }, errors: { (stringMessage) in
            errors(stringMessage)
        })
    }
    
    func configurationAPICall(_ baseURL: String, _ parameters: String, _ value: String) -> String {
        return baseURL + "?" + parameters + "=" + value + "&apiKey=89142a5c40d642bea88f0b6324abf451"
    }
}
