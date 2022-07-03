//
//  NewsProtocol.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import UIKit

// MARK: VIEW Output (Presenter -> View)
protocol PresenterToViewNewsProtocol: class {
    func onNewsFetchSuccess()
    func onNewsFetchError(errorString: ErrorModule, errorCode: Int)
    func onNewsFetchFailed(errorString: String)
    func showHUD()
    func hideHUD()
    
    func desSelectRowAt(row: Int)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterNewsProtocol: class {
    var view : PresenterToViewNewsProtocol? { get set }
    var interactor: PresenterToInteractorNewsProtocol? { get set }
    var router: PresenterToRouterNewsProtocol? { get set }
    var newString: [String]? { get set }
    var articlesModel: [ArticlesModule]? { get set }
    
    func viewDidLoad()
    
    func refresh()
    func numberOfRowsInSection() -> Int
    
    func textLabelText(indexPath: IndexPath) -> ArticlesModule?
    func didSelectRowSearch(arrayModel: ArticlesModule)
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorNewsProtocol: class {
    var presenter: InteractorToPresenterNewsProtocol? { get set }
    
    func loadNews()
    func retreiveNews(at index : Int)
    func retreiveNewsSeach(sourceName: ArticlesModule)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterNewsProtocol: class {
    func fetchNewsSuccess(result: NewsModule)
    func fetchNewsError(errorString: Int, errorMessage: ErrorModule)
    func fetchNewsFailed(errorString: String)
    
    func getNewsSuccess(_ news: ArticlesModule)
    func getNewsFailure()
}

// MARK: Router input (Presenter -> Router)
protocol PresenterToRouterNewsProtocol: class {
    static func createModule() -> UINavigationController
    func toPushSourceNewArticles(on view: PresenterToViewNewsProtocol, with source: ArticlesModule)
}


