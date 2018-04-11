//
//  UserDefaults.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 11/04/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favoritePodcastKey = "favoritePodcastKey"
    
    func fetchPodcasts() -> [Podcast] {
        guard let savedPodcastsData = UserDefaults.standard.data(forKey: UserDefaults.favoritePodcastKey) else {return []}
        guard let savedPodcasts = NSKeyedUnarchiver.unarchiveObject(with: savedPodcastsData) as? [Podcast] else {return []}
        return savedPodcasts
    }
    
    func savePodcasts(for podcastsToSave: [Podcast]) {
        let podcastsData = NSKeyedArchiver.archivedData(withRootObject: podcastsToSave)
        UserDefaults.standard.set(podcastsData, forKey: UserDefaults.favoritePodcastKey)
    }
    
    func deletePodcast(podcast: Podcast) {
        let podcasts = fetchPodcasts()
        let filteredPodcasts = podcasts.filter { (p) -> Bool in
            return p.trackName != podcast.trackName && p.artistName != podcast.artistName
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: filteredPodcasts)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritePodcastKey)
    }
}
