//
//  NewsViewController.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/2/22.
//

import PKHUD
import UIKit

class NewsViewController: BaseViewController, PresenterToViewNewsProtocol {
    
    var viewNews = NewsView()
    var presenter: ViewToPresenterNewsProtocol?
    var filteredContentArray: [ArticlesModule] = []
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSafeBackground(top: .white, bottom: .white)
        
        onViewNews()
        presenter?.viewDidLoad()
    }
    
    func onViewNews() {
        if #available(iOS 11, *){
            viewNews = NewsView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }
        else{
            viewNews = NewsView(frame: CGRect(x: 0, y: getStatusBarHeight(), width: self.view.frame.size.width, height: self.view.frame.size.height-self.getStatusBarHeight()))
        }
        
        viewNews.tableView.delegate = self
        viewNews.tableView.dataSource = self
        viewNews.searchBar.delegate = self
        viewNews.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        viewNews.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        self.view.addSubview(viewNews)
    }
    
    @objc func refresh() {
        presenter?.refresh()
    }
    
    func onNewsFetchSuccess() {
        
        self.viewNews.tableView.reloadData()
        self.viewNews.refreshControl.endRefreshing()
    }
    
    func onNewsFetchError(errorString: ErrorModule, errorCode: Int) {
        let alert = UIAlertController(title: NSLocalizedString("Information", comment: ""), message: String(format: "%@ - %i \n %@", errorString.code ?? "", errorCode, errorString.message ?? ""), preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
        self.viewNews.tableView.reloadData()
        self.viewNews.refreshControl.endRefreshing()
    }
    
    func onNewsFetchFailed(errorString: String) {
        let alert = UIAlertController(title: NSLocalizedString("Information", comment: ""), message: errorString, preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true)
        self.viewNews.tableView.reloadData()
        self.viewNews.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func desSelectRowAt(row: Int) {
        self.viewNews.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource , UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredContentArray.count
        }else {
            return presenter?.numberOfRowsInSection() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewNews.tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTableViewCell
        if searchActive {
            cell.setContentData(data: filteredContentArray[indexPath.row] as! ArticlesModule)
        }else {
            cell.setContentData(data: presenter?.textLabelText(indexPath: indexPath) as! ArticlesModule)
        }
        
        viewNews.tableView.rowHeight = screenHeight*0.4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            presenter?.didSelectRowSearch(arrayModel: filteredContentArray[indexPath.row])
            presenter?.deselectRowAt(index: indexPath.row)
        }else {
            presenter?.didSelectRowAt(index: indexPath.row)
            presenter?.deselectRowAt(index: indexPath.row)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filteredContentArray = (presenter?.articlesModel?.filter {
            ($0.source?.name?.range(of: searchBar.text!, options: .caseInsensitive) != nil
            || $0.author?.range(of: searchBar.text!, options:.caseInsensitive) != nil
             || $0.title?.range(of: searchBar.text!, options:.caseInsensitive) != nil
            || $0.publishedAt?.range(of: searchBar.text!, options:.caseInsensitive) != nil)
        })!
        
        if(searchBar.text != nil && searchBar.text != "") {
            searchActive = true;
        } else {
            searchActive = false;
            
        }
        hideKeyboard()
        viewNews.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if(searchBar.text!.isEmpty) {
            searchActive = false
            hideKeyboard()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContentArray = (presenter?.articlesModel?.filter {
            ($0.source?.name?.range(of: searchText, options: .caseInsensitive) != nil
            || $0.author?.range(of: searchText, options:.caseInsensitive) != nil
             || $0.title?.range(of: searchText, options:.caseInsensitive) != nil
            || $0.publishedAt?.range(of: searchText, options:.caseInsensitive) != nil)
        })!
        
        if(searchText.isEmpty || searchText == "") {
            searchActive = false
            hideKeyboard()
        } else {
            searchActive = true;
        }
        
        viewNews.tableView.reloadData()
    }
}
