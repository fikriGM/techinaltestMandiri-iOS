//
//  SourceRouter.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import Foundation
import UIKit

class SourceRouter: PresenterToRouterSourceProtocol {
    static func createSouceModule(with source: ArticlesModule) -> UIViewController {
        
        let viewController = SourceViewController()
        let presenter: ViewToPresenterSourcesProtocol & InteractorToPresenterSourceProtocol = SourcePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = SourceRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SourceInteractor()
        viewController.presenter?.interactor?.articlesModule = source
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func toPushSourcesDetail(on view: PresenterToViewSourceProtocol, with sourceDetailWebView: ArticlesModule) {
        let moveDetailSource = SourceWebViewDetailRouter.createModule(with: sourceDetailWebView)
        
        let viewController = view as! SourceViewController
        viewController.navigationController?.pushViewController(moveDetailSource, animated: true)
    }
}
