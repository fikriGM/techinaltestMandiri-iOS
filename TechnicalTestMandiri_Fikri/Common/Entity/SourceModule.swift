//
//  SourceModule.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import ObjectMapper

private let ID = "id"
private let NAME = "name"

struct SourceModule: Mappable {
    
    internal var id: String?
    internal var name: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map[ID]
        name <- map[NAME]
    }
    
}
