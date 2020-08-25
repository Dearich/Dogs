//
//  ModuleBuilder.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

protocol Builder {
    static func createMain() -> UIViewController
    static func createFavouritesModule() -> UIViewController
}
class ModuleBuilder: Builder {
    static func createFavouritesModule() -> UIViewController {
        let view = FavouritesViewController()
        let presenter = FavouritesPresenter(view: view)
        view.presenter = presenter
        return view
    }
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createImageViewController() -> ImageViewController {
        let view = ImageViewController()
        let presenter = ImagePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createSubBreedViewController() -> SubBreedViewController {
        let view = SubBreedViewController()
        let presenter = SubBreedPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
