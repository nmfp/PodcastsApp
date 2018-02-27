//
//  PodcastsSearchController.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 26/02/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit
import Alamofire

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [
        Podcast(trackName: "Lets build that app", artistName: "brian voong"),
        Podcast(trackName: "Lets build that app", artistName: "brian voong")
    ]
    
    let cellId = "cellId"
    
    let searchController = UISearchController(searchResultsController: nil)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        //Sets the searchBar for always show
        navigationItem.hidesSearchBarWhenScrolling = false
        //Maintains white background when searching
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    //MARK:- TableView methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = podcasts[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
//        let url = "https://itunes.apple.com/search?term=\(searchText)"
        
        let url = "https://itunes.apple.com/search"
        
        let parameters = ["term" : searchText, "media": "podcast"]
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
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
                
                searchResult.results.forEach({ (podcast) in
                    print("\(podcast.trackName ?? ""), \(podcast.artistName ?? "")")
                })
                
                self.podcasts = searchResult.results
                self.tableView.reloadData()
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
