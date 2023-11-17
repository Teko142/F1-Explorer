//
//  ViewController.swift
//  F1 Explorer
//
//  Created by Артур Олехно on 26/10/2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: DriversSearchViewController())
        let vc3 = UINavigationController(rootViewController: TeamsViewController())
        let vc4 = UINavigationController(rootViewController: ReactionViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "person.text.rectangle")
        vc3.tabBarItem.image = UIImage(systemName: "person.3")
        vc4.tabBarItem.image = UIImage(systemName: "gamecontroller")
        
        vc1.title = "Home"
        vc2.title = "Drivers"
        vc3.title = "Teams"
        vc4.title = "Reaction"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

