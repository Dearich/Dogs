//
//  Router.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class Router: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().prefersLargeTitles = false
        let listVC = generateNavController(viewControler: ModuleBuilder.createMain(), title: "Dogs", tabBarTitle: "List", imageName: "doc.plaintext")
        let favouritesVC = generateNavController(viewControler: ModuleBuilder.createFavouritesModule(),
                                                 title: "Favourites", tabBarTitle: "Favourites", imageName: "heart")
        viewControllers = [listVC, favouritesVC]
        
    }
    fileprivate func generateNavController(viewControler: UIViewController,
                                           title: String,
                                           tabBarTitle: String,
                                           imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewControler)
        viewControler.navigationItem.title = title
        viewControler.tabBarItem.image = UIImage(systemName: imageName)
        viewControler.tabBarItem.title = tabBarTitle
        return navController
    }
}
