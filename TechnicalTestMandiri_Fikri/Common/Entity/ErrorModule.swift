//
//  ErrorModule.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import Foundation
import ObjectMapper

private let STATUS = "status"
private let CODE = "code"
private let MESSAGE = "message"

struct ErrorModule: Mappable {
    
    internal var status: String?
    internal var code: String?
    internal var message: String?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        status  <- map[STATUS]
        code    <- map[CODE]
        message <- map[MESSAGE]
    }
}
