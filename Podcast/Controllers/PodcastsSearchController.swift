//
//  PodcastsSearchController.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/16.
//

import Foundation
import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [
        Podcast(trackName: "Keep it Short and Sweet", artistName: "Jhon"),
        Podcast(trackName: "Life is a race", artistName: "Austin"),
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
        print(1)
        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            
            self.podcasts = podcasts
            self.tableView.reloadData()
        }        
    }
    
    fileprivate func setupTableView(){
        // 1. register a cell for tableview
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    //MARK: UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        
        let podcast = self.podcasts[indexPath.row]
        cell.podcast = podcast
        
//        let podcast = self.podcasts[indexPath.row]
        
//        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
//        cell.textLabel?.numberOfLines = -1
//        cell.imageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
}
