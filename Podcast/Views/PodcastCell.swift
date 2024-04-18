//
//  PodcastCell.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/17.
//

import Foundation
import UIKit

class PodcastCell: UITableViewCell{
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast!{
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
        }
    }
}
