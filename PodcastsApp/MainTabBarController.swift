//
//  MainTabBarController.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 26/02/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        view.backgroundColor = .white
        
        
        viewControllers = [
            generateNavigationController(with: PodcastsSearchController(), title: "Search", image: #imageLiteral(resourceName: "search")),
            generateNavigationController(with: UIViewController(), title: "Favorites", image: #imageLiteral(resourceName: "favorites")),
            generateNavigationController(with: UIViewController(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        ]
        tabBar.tintColor = UIColor(red: 195/255, green: 58/255, blue: 255/255, alpha: 1)
    }
    
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
