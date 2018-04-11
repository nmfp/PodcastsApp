//
//  EpisodeCell.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 01/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pudDateLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    
    
    var episode: Episode! {
        didSet {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            
            pudDateLabel.text = dateFormatter.string(from: episode.pubDate)
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            
            let url = URL(string: episode.imageUrl?.toSecureHttps() ?? "")
//            print("ImageUrl: ", episode.imageUrl?.toSecureHttps() ?? "")
            episodeImageView.sd_setImage(with: url)
        }
    }
}
