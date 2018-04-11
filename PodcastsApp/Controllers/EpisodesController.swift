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
        
        APIService.shared.fetchEpisodes(feedUrl: urlString) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarButtons()
        setupTableView()
    }
    
    fileprivate func setupNavigationBarButtons() {
        
        let savedPodcasts = UserDefaults.standard.fetchPodcasts()
        let hasFavorite = savedPodcasts.index(where: {$0.trackName == self.podcast?.trackName && $0.artistName == self.podcast?.artistName}) != nil
        
        if hasFavorite {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: self, action: nil)
        }
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite))
//            UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchSavedFavorite))
        ]
    }
    
    @objc func handleSaveFavorite() {
        print("Saving info into userDefaults")
        guard let podcast = podcast else {return}
        var listOfPodcasts = UserDefaults.standard.fetchPodcasts()
        listOfPodcasts.append(podcast)
        let data = NSKeyedArchiver.archivedData(withRootObject: listOfPodcasts)
        
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritePodcastKey)
        
        showBadgeHighlight()
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "heart"), style: .plain, target: nil, action: nil)
    }
    
    fileprivate func showBadgeHighlight() {
        UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = "New"
    }
    
    @objc func handleFetchSavedFavorite() {
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoritePodcastKey) else {return}
        let savedPodcasts = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Podcast]
        
        savedPodcasts?.forEach {print($0.trackName ?? "")}
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        //        print(episode.title)
        //
        //        let window = UIApplication.shared.keyWindow
        //
        //        let playerDetailsView = PlayerDetailsView.initFromNib()
        //
        //        playerDetailsView.episode = episode
        //        playerDetailsView.frame = self.view.frame
        //
        //        window?.addSubview(playerDetailsView)
        
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
}


