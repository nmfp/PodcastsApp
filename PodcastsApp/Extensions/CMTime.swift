//
//  CMTime.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 04/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation
import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
}
