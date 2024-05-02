//
//  APIService.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/17.
//

import Foundation
import Alamofire
import FeedKit

class APIService {
    
    // singleton
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode])->()){
        guard let url = URL(string: feedUrl.toSecureHTTPS()) else { return }
        let parser = FeedParser(URL: url)
        // Parse asynchronously, not to block the UI.
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            // Do your thing, then back to the Main thread
            switch result{
            case .success(let feed):
                // associative enumeration values
                switch feed{
                case .atom(_):
                    break
                case let .rss(feed):
                    completionHandler(feed.toEpisodes())
                    break
                case .json(_):
                    break
                }
            case .failure(let error):
                print("Failed to parse feed: ", error)
            }
        }
    }
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        print("Searching for podcasts...")
        
        let url = "https://itunes.apple.com/search"
        let parameters = ["term":searchText, "media": "podcast"]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let error = dataResponse.error{
                print("Failed to contact yahoo", error)
                return
            }
            
            guard let data = dataResponse.data else { return }
            print(3)
            do{
                print(3)
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                print("Result Count: ", searchResult.resultCount)
                completionHandler(searchResult.results)
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
                
            } catch let decodeErr{
                print("Failed to decode: ", decodeErr)
            }
        }
        print(2)
    }
    
    struct SearchResults: Decodable{
        let resultCount: Int
        let results: [Podcast]
        
    }
    
    
}
