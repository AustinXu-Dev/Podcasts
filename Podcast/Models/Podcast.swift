//
//  Podcast.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/16.
//

import Foundation

struct Podcast: Decodable{
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}
