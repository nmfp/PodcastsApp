//
//  EpisodesController.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 01/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    let cellId = "cellId"
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            
            fetchEpisodes()
        }
    }
    
    var episodes = [Episode]()
    
    fileprivate func fetchEpisodes() {
        
        guard let urlString = podcast?.feedUrl else {return}
        let secureUrl = urlString.contains("https") ? urlString : urlString.replacingOccurrences(of: "http", with: "https")
        guard let url = URL(string: secureUrl) else {return}
        
        let parser = FeedParser(URL: url )
        
        parser?.parseAsync(result: { (result) in
            print("Successfully parse feed: ", result.isSuccess)
            
            //This switch test all possible result types
            switch result {
            case let .atom(feed):
                break
            case let .rss(feed):
                var episodes = [Episode]()
                
                //The items property contains the array of the elements in the rss/xml
                feed.items?.forEach({ (feedItem) in
                    let episode = Episode(feedItem: feedItem)
                    episodes.append(episode)
                })
                
                self.episodes = episodes
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case let .json(feed):
                break
            case let .failure(feed):
                break
                
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    
    //MARK:- TableView
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


