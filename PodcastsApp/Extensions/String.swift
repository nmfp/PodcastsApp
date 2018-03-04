//
//  String.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 01/03/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import Foundation

extension String {
    func toSecureHttps() -> String{
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}
