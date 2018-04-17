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
    static let downloadedEpisodesKey = "downloadedEpisodesKey"
    
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
    
    func downloadEpisode(episode: Episode) {
            var downloadedEpisodes = self.downloadedEpisodes()
            downloadedEpisodes.append(episode)
        self.saveEpisodes(episodes: downloadedEpisodes)
    }
    
    func downloadedEpisodes() -> [Episode] {
        guard let episodesData = data(forKey: UserDefaults.downloadedEpisodesKey) else {return []}
        do {
            let episodes = try JSONDecoder().decode([Episode].self, from: episodesData)
            return episodes
        }
        catch let encondeErr {
            print("Failed to enconde episode: ", encondeErr)
            return []
        }
    }
    
    func deleteEpisode(episode: Episode) {
        var downloadedEpisodes = self.downloadedEpisodes()
        guard let index = downloadedEpisodes.index(where: {$0.author == episode.author && $0.title == episode.title}) else {return}
        downloadedEpisodes.remove(at: index)
        self.saveEpisodes(episodes: downloadedEpisodes)
    }
    
    func saveEpisodes(episodes: [Episode]) {
        do {
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        }
        catch let encondeErr {
            print("Failed to enconde episode: ", encondeErr)
        }
    }
}
