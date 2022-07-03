//
//  NewsInteractor.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation
import CoreMIDI

class NewsInteractor: PresenterToInteractorNewsProtocol {
   
    weak var presenter: InteractorToPresenterNewsProtocol?
    var news: NewsModule?
    
    func loadNews() {
        NewsService.shared.getNews(success: { (statusCode, news) in
            self.news = news
            self.presenter?.fetchNewsSuccess(result: news)
        }, failure: { (code, error) in
            self.presenter?.fetchNewsError(errorString: code, errorMessage: error)
        }, errors: { (error) in
            self.presenter?.fetchNewsFailed(errorString: error)
        })
        
    }
    
    func retreiveNews(at index: Int) {
        guard let news = self.news, ((news.articles?.indices.contains(index)) != nil) else {
            self.presenter?.getNewsFailure()
            return 
        }
        
        self.presenter?.getNewsSuccess((self.news?.articles![index])!)
    }
    
    func retreiveNewsSeach(sourceName: ArticlesModule) {
        self.presenter?.getNewsSuccess(sourceName)
    }
    
}
