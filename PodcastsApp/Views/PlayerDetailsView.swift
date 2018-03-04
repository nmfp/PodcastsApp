//
//  PlayerDetailsView.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 04/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class PlayerDetailsView: UIView {
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            authorLabel.text = episode.author

            let urlString = episode.imageUrl?.toSecureHttps() ?? ""
            guard let url = URL(string: urlString) else {return}
            episodeImageView.sd_setImage(with: url, completed: nil);
        }
    }
    
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    @IBOutlet weak var playPauseButton: UIButton!
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
}
