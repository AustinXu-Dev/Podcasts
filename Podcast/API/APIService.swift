//
//  APIService.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/17.
//

import Foundation
import Alamofire

class APIService {
    
    // singleton
    static let shared = APIService()
    
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
