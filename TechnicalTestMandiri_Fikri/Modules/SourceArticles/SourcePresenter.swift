//
//  SourcePresenter.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation

class SourcePresenter: ViewToPresenterSourcesProtocol {
  
    var view: PresenterToViewSourceProtocol?
    var interactor: PresenterToInteractorSourceProtocol?
    var router: PresenterToRouterSourceProtocol?
    var sourcesString: [String]?
    var sourcesModule: [ArticlesModule]?
     
    func viewDidload() {
        self.view?.showHUD()
        interactor?.loadSources()
    }
    
    func refresh() {
        interactor?.loadSources()
    }
    
    func numberOfRowInSection() -> Int {
        guard let sourceString = self.sourcesString else {
            return 0
        }
        return sourceString.count
    }
    
    func textLabelSources(indexPath: IndexPath) -> ArticlesModule? {
        guard let sourceModel = self.sourcesModule else {
            return nil
        }
        return sourceModel[indexPath.row]
    }
    
    func didSelectedSearchRowAt(sourceArray: ArticlesModule) {
        interactor?.retreiveSourceSeach(sourceName: sourceArray)
    }
    
    func didSelectedRowAt(index: Int) {
        interactor?.retReiveSources(at: index)
    }
    
    func deSelectedRowAt(index: Int) {
        view?.deSelectedRowAt(row: index)
    }
}

extension SourcePresenter: InteractorToPresenterSourceProtocol {
    
    func fetchSourcesSuccess(resultArray: [ArticlesModule]) {
        self.sourcesString = resultArray.compactMap { $0.author }
        self.sourcesModule = resultArray
        view?.hideHUD()
        view?.onSourcesFetchSuccess()
    }
    
    func fetchSourcesError(errorString: Int, errorMessage: ErrorModule) {
        view?.hideHUD()
        view?.onSourcesFetchError(string: "\(errorString)", errorModule: errorMessage)
    }
    
    func fetchSourcesFailed(errorString: String) {
        view?.hideHUD()
        view?.onSourcesFetchFailed(string: errorString)
    }
    
    func getSourcesSuccess(_ sources: ArticlesModule) {
        router?.toPushSourcesDetail(on: view!, with: sources)
    }
    
    func getSourcesError() {
        view?.hideHUD()
        view?.onSourcesFetchFailed(string: "Couldn't retrieve sources by index")
    }
    
    
}
