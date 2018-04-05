//
//  UIApplication.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 05/04/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
