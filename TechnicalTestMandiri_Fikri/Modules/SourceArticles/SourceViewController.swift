//
//  SourceViewController.swift
//  TechnicalTestMandiri_Fikri
//
//  Created by Cashlez Macbook 2021 on 7/3/22.
//

import UIKit
import PKHUD

class SourceViewController: BaseViewController, PresenterToViewSourceProtocol {
    
    var sourceView = SourceView()
    var presenter: ViewToPresenterSourcesProtocol?
    var filteredContentArray: [ArticlesModule] = []
    var searchActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSafeBackground(top: .white, bottom: .white)
        self.setViewSources()
        presenter?.viewDidload()
    }
    
    func setViewSources() {
        if #available(iOS 11, *){
            sourceView = SourceView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }
        else{
            sourceView = SourceView(frame: CGRect(x: 0, y: getStatusBarHeight(), width: self.view.frame.size.width, height: self.view.frame.size.height-self.getStatusBarHeight()))
        }
        
        sourceView.tableView.delegate = self
        sourceView.tableView.dataSource = self
        sourceView.searchBar.delegate = self
        sourceView.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "sourceCell")
        sourceView.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.view.addSubview(sourceView)
    }
    
    @objc func refresh() {
        presenter?.refresh()
    }
    
    func onSourcesFetchSuccess() {
        self.sourceView.tableView.reloadData()
        self.sourceView.refreshControl.endRefreshing()
    }
    
    func onSourcesFetchError(string: String) {
        let alert = UIAlertController(title: NSLocalizedString("Information", comment: ""), message: NSLocalizedString(string, comment: ""), preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        self.sourceView.refreshControl.endRefreshing()
    }
    
    func onSourcesFetchError(string: String, errorModule: ErrorModule) {
        let alert = UIAlertController(title: NSLocalizedString("Information", comment: ""), message: String(format: "%@ - %@ \n %@", errorModule.status ?? "", string, errorModule.message ?? ""), preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func onSourcesFetchFailed(string: String) {
        let alert = UIAlertController(title: NSLocalizedString("Information", comment: ""), message: NSLocalizedString(string, comment: ""), preferredStyle: .alert)
        let okButton = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil)
        alert.addAction(okButton)
        
        self.present(alert, animated: true, completion: nil)
        self.sourceView.refreshControl.endRefreshing()
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
    func deSelectedRowAt(row: Int) {
        self.sourceView.tableView.deselectRow(at: IndexPath(row: row, section: 0), animated: true)
    }
    
}

extension SourceViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredContentArray.count
        }
        return presenter?.numberOfRowInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourceView.tableView.dequeueReusableCell(withIdentifier: "sourceCell") as! NewsTableViewCell
        if searchActive {
            cell.setContentData(data: filteredContentArray[indexPath.row] as! ArticlesModule)
        }else {
            cell.setContentData(data: presenter?.textLabelSources(indexPath: indexPath) as! ArticlesModule)
        }
        
        sourceView.tableView.rowHeight = screenHeight*0.4
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            presenter?.didSelectedSearchRowAt(sourceArray: filteredContentArray[indexPath.row])
            presenter?.deSelectedRowAt(index: indexPath.row)
        }else {
            presenter?.didSelectedRowAt(index: indexPath.row)
            presenter?.deSelectedRowAt(index: indexPath.row)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filteredContentArray = (presenter?.sourcesModule?.filter {
            ($0.title?.range(of: searchBar.text!, options: .caseInsensitive) != nil
             || $0.author?.range(of: searchBar.text!, options:.caseInsensitive) != nil
             || $0.publishedAt?.range(of: searchBar.text!, options:.caseInsensitive) != nil) })!
        
        if(searchBar.text != nil) {
            searchActive = true;
        } else {
            searchActive = false;
            
        }
        sourceView.searchBar.endEditing(true)
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
        filteredContentArray = (presenter?.sourcesModule?.filter {
            ($0.title?.range(of: searchText, options: .caseInsensitive) != nil
            || $0.author?.range(of: searchText, options:.caseInsensitive) != nil
            || $0.publishedAt?.range(of: searchText, options:.caseInsensitive) != nil) })!
        
        if(searchText.isEmpty || searchText == "") {
            searchActive = false
            hideKeyboard()
        } else {
            searchActive = true;
        }
        
        sourceView.tableView.reloadData()
    }
    
}
