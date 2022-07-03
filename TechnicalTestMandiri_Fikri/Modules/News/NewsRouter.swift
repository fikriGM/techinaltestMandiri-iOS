//
//  NewsRouter.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import UIKit

class NewsRouter: PresenterToRouterNewsProtocol {
    static func createModule() -> UINavigationController {
        
        let viewController = NewsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterNewsProtocol & InteractorToPresenterNewsProtocol = NewsPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = NewsRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = NewsInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    func toPushSourceNewArticles(on view: PresenterToViewNewsProtocol, with source: ArticlesModule) {
        let sourceNewArticels = SourceRouter.createSouceModule(with: source)
        
        let viewController = view as! NewsViewController
        viewController.navigationController?.pushViewController(sourceNewArticels, animated: true)
    }
}
