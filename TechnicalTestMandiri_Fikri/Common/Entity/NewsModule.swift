//
//  NewsModule.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//


import Foundation
import ObjectMapper

private let STATUS = "status"
private let TOTALRESULTS = "totalResults"
private let ARTICLES = "articles"
private let CODE = "code"
private let MESSAGE = "message"

struct NewsModule: Mappable {
    
    internal var status: String?
    internal var totalResults: Int?
    internal var articles: [ArticlesModule]?
    internal var code: String?
    internal var message: String?
    
    
    init?(map: Map) { }
    
   mutating func mapping(map: Map) {
       status       <- map[STATUS]
       totalResults <- map[TOTALRESULTS]
       articles     <- map[ARTICLES]
       code         <- map[CODE]
       message      <- map[MESSAGE]
    }
    
}
