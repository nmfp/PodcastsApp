//
//  Episode.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 01/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation
import FeedKit

struct Episode {
    var title: String
    var pubDate: Date
    var description: String
    var imageUrl: String?
    var author: String
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.iTunes?.iTunesSubtitle ?? feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
        self.author = feedItem.iTunes?.iTunesAuthor ?? ""
    }
}
