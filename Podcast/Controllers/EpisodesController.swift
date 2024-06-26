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
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { episodes in
            self.episodes = episodes
            DispatchQueue.main.async{
                self.tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        print("Trying to play episode: ", episode.title)
        
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
            let window = scene.windows.first
            // Use the window here
            
            // Showing Nib View because View is the first component
            let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailsView", owner: self)?.first as! PlayerDetailsView
            
            playerDetailsView.episode = episode
            
            playerDetailsView.frame = self.view.frame
            window?.addSubview(playerDetailsView)
            
        }
    }
    
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
