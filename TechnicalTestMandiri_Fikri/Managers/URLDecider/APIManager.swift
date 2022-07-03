//
//  APIManager.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation

class APIManager {
    static let shared = { APIManager() }()
    
    lazy var urldecider: String = {
        return "https://newsapi.org/v2/"
    }()
}
