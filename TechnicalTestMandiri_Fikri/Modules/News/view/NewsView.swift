//
//  NewsView.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import Foundation
import UIKit

class NewsView: UIView {
    
    var tableView = UITableView()
    var searchBar = UISearchBar()
    var refreshControl = UIRefreshControl()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let navBar = UIView(frame: CGRect(x: 0, y: 40, width: self.frame.size.width, height: 120))
        navBar.backgroundColor = .white
        navBar.layer.shadowOpacity = 0.5
        navBar.layer.shadowRadius = 5
        self.addSubview(navBar)
        
        let navTitle = UILabel(frame: CGRect(x: 30, y: 20, width: navBar.frame.size.width, height: 30))
        navTitle.text = "News Category"
        navTitle.font = .systemFont(ofSize: 16)
        navTitle.textAlignment = .left
        navBar.addSubview(navTitle)
        
        searchBar = UISearchBar(frame: CGRect(x: 20, y: 70, width: navBar.frame.size.width - 40, height: 50))
        searchBar.placeholder = "" + NSLocalizedString("Search...", comment: "")
        searchBar.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.layer.cornerRadius = 10
        navBar.addSubview(searchBar)
    
        tableView = UITableView(frame: CGRect(x: 0, y: (navBar.frame.maxY) + 5, width: frame.self.width, height: self.frame.size.height))
        self.addSubview(tableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        self.tableView.addSubview(refreshControl)
    }
}
