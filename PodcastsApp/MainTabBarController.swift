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
        
        setupPlayerDetailView()
        
        
    }
    
    @objc func minimizePlayerDetails() {
        print("minimizedPlayerDetails")
        
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            
            self.tabBar.transform = .identity
            
            self.playerDetailsView.maximizedStackView.alpha = 0
            self.playerDetailsView.miniPlayerView.alpha = 1
        }, completion: nil)
    }
    
    func maximizePlayerDetails(episode: Episode?) {
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        minizedTopAnchorConstraint.isActive = false
        
        bottomAnchorConstraint.constant = 0
        
        if episode != nil {
            playerDetailsView.episode = episode
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            
            self.tabBar.transform = CGAffineTransform(scaleX: 0, y: 100)
            
            self.playerDetailsView.maximizedStackView.alpha = 1
            self.playerDetailsView.miniPlayerView.alpha = 0
        }, completion: nil)
    }
    
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    let playerDetailsView = PlayerDetailsView.initFromNib()
    
    fileprivate func setupPlayerDetailView() {
        
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
        //How to add a subview to parent but below some view that already exists
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        
        maximizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchorConstraint.isActive = true
        
        bottomAnchorConstraint = playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true
        
        minizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        
        NSLayoutConstraint.activate([
            playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
