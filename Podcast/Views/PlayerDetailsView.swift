//
//  PlayerDetailsView.swift
//  Podcast
//
//  Created by Austin Xu on 2024/5/2.
//

import Foundation
import UIKit
import AVKit

class PlayerDetailsView: UIView {
    
    var episode: Episode! {
        didSet{
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            
            playEpisode()
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    fileprivate func playEpisode() {
        print("Trying to play episode at url: ", episode.streamUrl)
        
        //MARK: AV Player play the audio
        guard let url = URL(string: episode.streamUrl) else {return}
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    //MARK: IB Actions and Outlets

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
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet{
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    @objc func handlePlayPause() {
        if player.timeControlStatus == .paused{
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        } else{
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
}
