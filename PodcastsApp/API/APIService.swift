//
//  APIService.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 27/02/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        //        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        let baseiTunesSearchURL = "https://itunes.apple.com/search"
        
        let parameters = ["term" : searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact yahoo:", err)
                return
            }
            
            guard let data = dataResponse.data else {return}
            
            //            let dummyString = String(data: data, encoding: String.Encoding.utf8)
            //            print(dummyString ?? "")
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                print("Results count: ", searchResult.resultCount)
                
                completionHandler(searchResult.results)
                
                searchResult.results.forEach({ (podcast) in
                    print("\(podcast.trackName ?? ""), \(podcast.artistName ?? "")")
                })
                
//                self.podcasts = searchResult.results
//                self.tableView.reloadData()
            }
            catch let decodeErr {
                print("Failed to decode: ", decodeErr)
            }
        }
    }
}

struct SearchResults: Decodable {
    var resultCount: Int
    let results: [Podcast]
}
