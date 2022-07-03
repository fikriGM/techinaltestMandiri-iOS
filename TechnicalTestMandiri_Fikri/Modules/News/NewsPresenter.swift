//
//  NewsPresenter.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation
import CoreMIDI

class NewsPresenter: ViewToPresenterNewsProtocol {
   
    //MARK: properties
    var view: PresenterToViewNewsProtocol?
    var interactor: PresenterToInteractorNewsProtocol?
    var router: PresenterToRouterNewsProtocol?
    var newString: [String]?
    var articlesModel: [ArticlesModule]?
    
    func viewDidLoad() {
        self.view?.showHUD()
        interactor?.loadNews()
    }
    
    func refresh() {
        interactor?.loadNews()
    }
    
    func numberOfRowsInSection() -> Int {
        guard let newsString = self.articlesModel else {
            return  0
        }
        return newsString.count
    }
    
    func textLabelText(indexPath: IndexPath) -> ArticlesModule? {
        guard let newsArticle = self.articlesModel else {
            return nil
        }
        return newsArticle[indexPath.row]
    }
    
    func didSelectRowSearch(arrayModel: ArticlesModule) {
        print("klik search \(arrayModel.source?.id)")
        interactor?.retreiveNewsSeach(sourceName: arrayModel)
    }
    
    func didSelectRowAt(index: Int) {
        interactor?.retreiveNews(at: index)
    }
    
    func deselectRowAt(index: Int) {
        view?.desSelectRowAt(row: index)
    }
    
}

extension NewsPresenter: InteractorToPresenterNewsProtocol {

    func fetchNewsSuccess(result: NewsModule) {
        self.newString = result.articles?.compactMap { $0.author }
        self.articlesModel = result.articles
        view?.hideHUD()
        view?.onNewsFetchSuccess()
    }
    
    func fetchNewsError(errorString: Int, errorMessage: ErrorModule) {
        view?.hideHUD()
        view?.onNewsFetchError(errorString: errorMessage, errorCode: errorString)
    }
    
    func fetchNewsFailed(errorString: String) {
        view?.hideHUD()
        view?.onNewsFetchFailed(errorString: errorString)
    }
    
    func getNewsSuccess(_ news: ArticlesModule) {
        router?.toPushSourceNewArticles(on: view!, with: news)
    }
    
    func getNewsFailure() {
        view?.hideHUD()
        view?.onNewsFetchFailed(errorString: "Couldn't retrieve news by index")
    }
    
}
