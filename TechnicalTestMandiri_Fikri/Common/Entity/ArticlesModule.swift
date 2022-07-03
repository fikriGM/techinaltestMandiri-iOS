//
//  ArticlesModule.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation
import ObjectMapper

private let SOURCE = "source"
private let AUTHOR = "author"
private let TITLE = "title"
private let DESCRIPTION = "description"
private let URL = "url"
private let URLTOIMAGE = "urlToImage"
private let PUBLISHEDAT = "publishedAt"
private let CONTENT = "content"

struct ArticlesModule: Mappable {
    internal var source: SourceModule?
    internal var author: String?
    internal var title: String?
    internal var description: String?
    internal var url: String?
    internal var urlToImage: String?
    internal var publishedAt: String?
    internal var content: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        source          <- map[SOURCE]
        author          <- map[AUTHOR]
        title           <- map[TITLE]
        description     <- map[DESCRIPTION]
        url             <- map[URL]
        urlToImage      <- map[URLTOIMAGE]
        publishedAt     <- map[PUBLISHEDAT]
        content         <- map[CONTENT]
    }
    
}
