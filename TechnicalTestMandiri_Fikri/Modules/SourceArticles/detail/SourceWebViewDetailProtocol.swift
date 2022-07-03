//
//  SourceWebViewDetailProtocol.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import UIKit

protocol PresenterToViewSourceWebViewProtocol: class {
    
    func onGetWebViewFromURLSuccess(stringURL: String)
    func onGetWebViewFromURLFailed(stringerror: String)
    func showHUD()
    func hideHUD()
}

protocol ViewToPresenterSourceWebViewProtocol: class {
    var view: PresenterToViewSourceWebViewProtocol? { get set }
    var interactor: PresenterToInteractorSourceWebViewDetailProtocol? { get set }
    var router: PresenterToRouterSourceWebViewDetailProtocol? { get set }
    
    func viewDidload()
}

protocol PresenterToInteractorSourceWebViewDetailProtocol: class {
    
    var presenter: InteractorToPresenterSourceWebViewDetailProtocol? { get set }
    var urlArticels: ArticlesModule? { get set }
    func getLoadWebViewFromURL()
}

protocol InteractorToPresenterSourceWebViewDetailProtocol: class {
    func getWebViewFromURLSuccess(stringURL: String)
    func getWebViewFromURLError(string: String)
}

protocol PresenterToRouterSourceWebViewDetailProtocol: class {
    static func createModule(with artichels: ArticlesModule) -> UIViewController
}

