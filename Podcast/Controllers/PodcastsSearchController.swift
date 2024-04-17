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
        print(searchText)
        // later implement Alamofire to search iTunes API
        
//        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":searchText, "media": "podcast"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error{
                print("Failed to contact yahoo", error)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do{
                
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                print("Result Count: ", searchResult.resultCount)
                self.podcasts = searchResult.results
                self.tableView.reloadData()
                
            } catch let decodeErr{
                print("Failed to decode: ", decodeErr)
            }
        }
    }
    
    struct SearchResults: Decodable{
        let resultCount: Int
        let results: [Podcast]
        
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
        
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
}
