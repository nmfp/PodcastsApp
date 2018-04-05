//
//  PlayerDetailsView+Gestures.swift
//  PodcastsApp
//
//  Created by Nuno Pereira on 05/04/2018.
//  Copyright © 2018 Nuno Pereira. All rights reserved.
//

import UIKit

extension PlayerDetailsView {
    
    fileprivate func handlePanEnded(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            
            //-200 since it was the value used before
            if translation.y < -200 || velocity.y < -500 {
                //It is nil since episode is not being changed
                UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: nil)
            }
            else {
                self.miniPlayerView.alpha = 1
                self.maximizedStackView.alpha = 0
            }
        }, completion: nil)
    }
    
    fileprivate func handlePanChanged(_ gesture: UIPanGestureRecognizer) {
        //Get the number of pixels that were dragged related to superView
        let translation = gesture.translation(in: self.superview)
        //Making view much bigger as the number of pixels dragged
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
        //Applied the division with a high number to make it faint as dragging
        self.miniPlayerView.alpha = 1 + translation.y / 200
        //Since translation is a negative number because the way of scrolling is applied a - operator
        self.maximizedStackView.alpha = -translation.y / 200
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            handlePanChanged(gesture)
        } else if gesture.state == .ended {
            handlePanEnded(gesture)
        }
    }
    
    @objc func handleTapMaximize() {
        UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: nil)
    }
    
    
    @objc func handleDismissalPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            let translation = gesture.translation(in: self.superview)
            print("     Dismissal: ", translation.y)
            maximizedStackView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        }
        else if gesture.state == .ended {
            let translation = gesture.translation(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.maximizedStackView.transform = .identity
                
                if translation.y > 50 {
                    let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
                    mainTabBarController?.minimizePlayerDetails()
                }
            })
        }
    }
}
