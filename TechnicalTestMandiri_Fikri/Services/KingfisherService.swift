//
//  KingfisherService.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation
import Kingfisher

class KingfisherService {
    static let shared = { KingfisherService() } ()
    
    func loadImageFrom(urlString: String,
                       success: @escaping (Data) -> (),
                       failure: @escaping (KingfisherError) -> ()) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                print("Data: \(value.originalData)")
                success(value.originalData)
            case .failure(let error):
                print("Error: \(error)")
                failure(error)
            }
        }
        
    }
}
