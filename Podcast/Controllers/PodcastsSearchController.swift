//
//  PodcastsSearchController.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/16.
//

import Foundation
import UIKit

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
    
    let podcasts = [
        Podcast(name: "Keep it Short and Sweet", artistName: "Jhon"),
        Podcast(name: "Life is a race", artistName: "Austin"),
    ]
    
    let cellId = "cellId"
    
    // Implement UISearchController
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
                
    }
    
    //MARK: Setup Work
    
    fileprivate func setupSearchBar(){
        navigationItem.searchController = searchController
        // Make search bar showing all the time
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // later implement Alamofire to search iTunes API
    }
    
    fileprivate func setupTableView(){
        // 1. register a cell for tableview
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK: UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = self.podcasts[indexPath.row]
        
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
}
