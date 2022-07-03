//
//  SourceWebViewDetailViewController.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import Foundation
import UIKit
import PKHUD
import WebKit

class SourceWebViewDetailViewController: BaseViewController, PresenterToViewSourceWebViewProtocol {
   
    var sourceWebView = SourceWebViewDetailView()
    var presenter: ViewToPresenterSourceWebViewProtocol?
    var navigationType : WKNavigationType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11, *){
            sourceWebView = SourceWebViewDetailView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }else{
            sourceWebView = SourceWebViewDetailView(frame: CGRect(x: 0, y: self.getStatusBarHeight(), width: self.view.frame.size.width, height: self.view.frame.size.height-self.getStatusBarHeight()))
        }
        presenter?.viewDidload()
        view.addSubview(sourceWebView)
    }
    
    func onGetWebViewFromURLSuccess(stringURL: String) {
        let url = URL(string: stringURL)!
        sourceWebView.webView =  WKWebView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        sourceWebView.webView.navigationDelegate = self
        sourceWebView.webView.translatesAutoresizingMaskIntoConstraints = false
        let websiteDataTypes = NSSet(array: [WKWebsiteDataTypeDiskCache, WKWebsiteDataTypeMemoryCache])
        let dateMillis = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes as! Set<String>, modifiedSince: dateMillis, completionHandler:{ })
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.allowsPictureInPictureMediaPlayback = true
        sourceWebView.webView.configuration.preferences = configuration.preferences
        sourceWebView.webView.load(URLRequest(url: url))
        sourceWebView.webView.allowsBackForwardNavigationGestures = true
    }
   
    func onGetWebViewFromURLFailed(stringerror: String) {
        print("string error: \(stringerror)")
        let alert = UIAlertController(title: NSLocalizedString("Information", comment: ""), message: NSLocalizedString(stringerror, comment: ""), preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
}

extension SourceWebViewDetailViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideHUD()
        webView.evaluateJavaScript("document.body.innerHTML") { result, error in
            guard let html = result as? String , error == nil else {
                return
            }
        }
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       hideHUD()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        return true
    }
}
