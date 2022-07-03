//
//  ImageDataService.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import UIKit

class ImageDataService {
    static let shared = { ImageDataService() } ()
    
    func convertToUIImage(from data: Data) -> UIImage {
        return UIImage(data: data)!
    }
}
