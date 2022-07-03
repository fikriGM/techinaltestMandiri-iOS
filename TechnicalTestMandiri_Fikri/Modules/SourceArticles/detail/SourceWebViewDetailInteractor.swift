//
//  SourceWebViewDetailInteractor.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import Foundation

class SourceWebViewDetailInteractor: PresenterToInteractorSourceWebViewDetailProtocol {
    
    weak var presenter: InteractorToPresenterSourceWebViewDetailProtocol?
    var urlArticels: ArticlesModule?
    
    func getLoadWebViewFromURL() {
        if urlArticels?.url != nil && urlArticels?.url != "" {
            self.presenter?.getWebViewFromURLSuccess(stringURL: urlArticels!.url!)
            
        }else {
            self.presenter?.getWebViewFromURLError(string: "error get webview from URL")
        }
    }
    
}
