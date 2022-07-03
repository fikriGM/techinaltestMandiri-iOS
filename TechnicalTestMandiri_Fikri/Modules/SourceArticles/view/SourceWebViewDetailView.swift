//
//  SourceWebViewDetailView.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import UIKit
import WebKit

class SourceWebViewDetailView: UIView {
    let contentView = UIView()
    var webView:  WKWebView!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        self.addSubview(contentView)
        contentView.addSubview(webView)
        self.setViewConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setViewConstraint(){
        contentView.anchor(top: self.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: self.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        contentView.backgroundColor = .white
        
        webView.anchor(top: contentView.topAnchor, left: self.leadingAnchor, right: self.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: screenWidth, height: screenHeight))
        
    }
}
