//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Austin Xu on 2024/5/2.
//

import Foundation
import UIKit

class PlayerDetailsView: UIView {
    
    var episode: Episode! {
        didSet{
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }

    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
        
    }
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    
}
