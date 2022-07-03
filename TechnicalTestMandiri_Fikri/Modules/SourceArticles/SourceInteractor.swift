//
//  SourceInteractor.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation

class SourceInteractor: PresenterToInteractorSourceProtocol {
   
    weak var presenter: InteractorToPresenterSourceProtocol?
    var sourceArray: [ArticlesModule]?
    var articlesModule: ArticlesModule?
    
    func loadSources() {

        SourceService.shared.getSource(source: articlesModule?.source?.id ?? "", success: { (statusCode, result) in
            self.sourceArray = result.articles
            self.presenter?.fetchSourcesSuccess(resultArray: self.sourceArray ?? [])
        }, failure: { (statusCode, resultError) in
            self.presenter?.fetchSourcesError(errorString: statusCode, errorMessage: resultError)
        }, errors: { (resultString) in
            self.presenter?.fetchSourcesFailed(errorString: resultString)
        })
    }
    
    func retReiveSources(at index: Int) {
        guard let res = self.sourceArray, res.indices.contains(index) else {
            return
        }
        self.presenter?.getSourcesSuccess(self.sourceArray![index])
    }
    
    func retreiveSourceSeach(sourceName: ArticlesModule) {
        self.articlesModule = sourceName
        self.presenter?.getSourcesSuccess(articlesModule!)
    }
}
