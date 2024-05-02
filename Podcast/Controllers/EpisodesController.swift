//
//  EpisodesController.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/30.
//

import Foundation
import UIKit
import FeedKit

class EpisodesController: UITableViewController{
    
    var podcast: Podcast? {
        didSet{
            navigationItem.title = podcast?.trackName
            
            fetchEpisodes()
        }
    }
    
    fileprivate func fetchEpisodes() {
        print("Looking for episodes at feed url: ", podcast?.feedUrl ?? "")
        
        guard let feedUrl = podcast?.feedUrl else { return }
        guard let url = URL(string: feedUrl) else { return }
        let parser = FeedParser(URL: url)
        // Parse asynchronously, not to block the UI.
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            // Do your thing, then back to the Main thread
            switch result{
            case .success(let feed):
                // associative enumeration values
                switch feed{
                case let .atom(feed):
                    break
                case let .rss(feed):
                    
                    var episodes = [Episode]() // blank Episode array
                    
                    
                    feed.items?.forEach({ (feedItem) in
                        let episode = Episode(feedItem: feedItem)
                        episodes.append(episode)
                    })
                    
                    self.episodes = episodes
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    break
                case let .json(feed):
                    break
                }
                
            case .failure(let error):
                print("Failed to parse feed: ", error)
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    //MARK: Setup Work
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
}
