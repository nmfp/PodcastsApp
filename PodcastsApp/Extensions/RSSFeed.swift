//
//  RSSFeed.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 01/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation
import FeedKit

extension RSSFeed {
    func toEpisodes() -> [Episode] {
        
        var episodes = [Episode]()
        
        //Since some episodes dont have image we take the podcast image to all episodes
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        //The items property contains the array of the elements in the rss/xml
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            if episode.imageUrl == nil {
                episode.imageUrl = imageUrl
            }
            
            episodes.append(episode)
        })
        
        return episodes
    }
}
