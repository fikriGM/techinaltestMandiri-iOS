//
//  SourceProtocol.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import UIKit

protocol PresenterToViewSourceProtocol: class {
    func onSourcesFetchSuccess()
    func onSourcesFetchError(string: String, errorModule: ErrorModule)
    func onSourcesFetchFailed(string: String)
    func setViewSources()
    func showHUD()
    func hideHUD()
    func deSelectedRowAt(row: Int)
}

protocol ViewToPresenterSourcesProtocol: class {
    var view: PresenterToViewSourceProtocol? { get set }
    var interactor: PresenterToInteractorSourceProtocol? { get set }
    var router: PresenterToRouterSourceProtocol? { get set }
    var sourcesString: [String]? { get set }
    var sourcesModule: [ArticlesModule]? { get set }
    
    func viewDidload()
    func refresh()
    func numberOfRowInSection() -> Int
    func textLabelSources(indexPath: IndexPath) -> ArticlesModule?
    func didSelectedSearchRowAt(sourceArray: ArticlesModule)
    func didSelectedRowAt(index: Int)
    func deSelectedRowAt(index: Int)
}

protocol PresenterToInteractorSourceProtocol: class {
    var presenter: InteractorToPresenterSourceProtocol? { get set }
    
    var articlesModule: ArticlesModule? { get set }
    func loadSources()
    func retreiveSourceSeach(sourceName: ArticlesModule)
    func retReiveSources(at index: Int)
}

protocol InteractorToPresenterSourceProtocol: class {
    func fetchSourcesSuccess(resultArray: [ArticlesModule])
    func fetchSourcesError(errorString: Int, errorMessage: ErrorModule)
    func fetchSourcesFailed(errorString: String)
    
    func getSourcesSuccess(_ sources: ArticlesModule)
    func getSourcesError()
}

protocol PresenterToRouterSourceProtocol: class {
    static func createSouceModule(with source: ArticlesModule) -> UIViewController
    
    func toPushSourcesDetail(on view: PresenterToViewSourceProtocol, with sourceDetailWebView: ArticlesModule)
}


