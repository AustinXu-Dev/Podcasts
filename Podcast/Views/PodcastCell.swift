//
//  PodcastCell.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/17.
//

import Foundation
import UIKit
import SDWebImage

class PodcastCell: UITableViewCell{
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast!{
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            
//            print("Loading image with url: ", podcast.artworkUrl600 ?? "")
            
            guard let url = URL(string: podcast.artworkUrl600?.toSecureHTTPS() ?? "") else {return}
            
//            URLSession.shared.dataTask(with: url){ (data,_,_) in
//                print("Finished downloading image data: ", data)
//                
//                guard let data = data else {return}
//                DispatchQueue.main.async {
//                    self.podcastImageView.image = UIImage(data: data)
//                }
//                
//            }.resume()
            
            podcastImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
