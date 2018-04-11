//
//  Podcast.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 26/02/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class Podcast: NSObject, Decodable, NSCoding {
    func encode(with aCoder: NSCoder) {
        print("Trying to transform Podcast into Data")
        aCoder.encode(trackName ?? "", forKey: "trackNameKey")
        aCoder.encode(artistName ?? "", forKey: "artistNameKey")
        aCoder.encode(artworkUrl600 ?? "", forKey: "artworkKey")
        aCoder.encode(feedUrl ?? "", forKey: "feedUrlKey")
        aCoder.encode(trackCount ?? -1, forKey: "trackCountKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("Trying to turn Data into Podcast")
        self.trackName = aDecoder.decodeObject(forKey: "trackNameKey") as? String
        self.artistName = aDecoder.decodeObject(forKey: "artistNameKey") as? String
        self.artworkUrl600 = aDecoder.decodeObject(forKey: "artworkKey") as? String
        self.feedUrl = aDecoder.decodeObject(forKey: "feedUrlKey") as? String
        self.trackCount = aDecoder.decodeObject(forKey: "trackCountKey") as? Int
    }
    
    var trackName: String?
    var artistName: String?
    var artworkUrl600: String?
    var trackCount: Int?
    var feedUrl: String?
}
