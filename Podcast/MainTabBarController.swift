//
//  MainTabBarController.swift
//  Podcast
//
//  Created by Austin Xu on 2024/4/15.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        
        tabBar.tintColor = .purple
        tabBar.barTintColor = .gray
        
        setupViewControllers()
    }
    
    //MARK: Setup Functions
    
    func setupViewControllers(){
        viewControllers = [
            generateNavigationController(with: PodcastsSearchController(), title: "Search", image: UIImage(named: "search")!),
            generateNavigationController(with: ViewController(), title: "Favourites", image: UIImage(named: "favorites")!),
            generateNavigationController(with: ViewController(), title: "Downloads", image: UIImage(named: "downloads")!)
        ]
    }
    
    //MARK: Helper Functioins
    
    fileprivate func generateNavigationController(with rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController{
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
