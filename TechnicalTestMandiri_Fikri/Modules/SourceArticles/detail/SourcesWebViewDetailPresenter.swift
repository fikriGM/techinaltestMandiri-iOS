//
//  SourcesWebViewDetailPresenter.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import Foundation

class SourcesWebViewDetailPresenter: ViewToPresenterSourceWebViewProtocol {
    var view: PresenterToViewSourceWebViewProtocol?
    var interactor: PresenterToInteractorSourceWebViewDetailProtocol?
    var router: PresenterToRouterSourceWebViewDetailProtocol?
    func viewDidload() {
        self.view?.showHUD()
        interactor?.getLoadWebViewFromURL()
    }
}

extension SourcesWebViewDetailPresenter: InteractorToPresenterSourceWebViewDetailProtocol {
    
    func getWebViewFromURLSuccess(stringURL: String) {
        view?.hideHUD()
        view?.onGetWebViewFromURLSuccess(stringURL: stringURL)
    }
    
    func getWebViewFromURLError(string: String) {
        view?.hideHUD()
        view?.onGetWebViewFromURLFailed(stringerror: string)
    }

}
