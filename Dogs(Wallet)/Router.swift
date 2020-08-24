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
        let listVC = generateNavController(viewControler: ModuleBuilder.createMain(), title: "Dogs", tabBarTitle: "List")
        let favouritesVC = generateNavController(viewControler: ModuleBuilder.createFavouritesModule(),
                                                 title: "Favourites", tabBarTitle: "Favourites")
        viewControllers = [listVC, favouritesVC]
        
    }
    fileprivate func generateNavController(viewControler: UIViewController, title: String, tabBarTitle: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewControler)
        viewControler.navigationItem.title = title
        navController.title = tabBarTitle
        return navController
    }
}
