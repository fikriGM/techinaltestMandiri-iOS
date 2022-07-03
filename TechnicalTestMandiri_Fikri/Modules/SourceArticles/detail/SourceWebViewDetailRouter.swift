//
//  SourceWebViewDetailRouter.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import Foundation
import UIKit

class SourceWebViewDetailRouter: PresenterToRouterSourceWebViewDetailProtocol {
    static func createModule(with artichels: ArticlesModule) -> UIViewController {
        
        let viewController = SourceWebViewDetailViewController()
        let presenter: ViewToPresenterSourceWebViewProtocol & InteractorToPresenterSourceWebViewDetailProtocol = SourcesWebViewDetailPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.view = viewController
        viewController.presenter?.router = SourceWebViewDetailRouter()
        viewController.presenter?.interactor = SourceWebViewDetailInteractor()
        viewController.presenter?.interactor?.urlArticels = artichels
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    
}
