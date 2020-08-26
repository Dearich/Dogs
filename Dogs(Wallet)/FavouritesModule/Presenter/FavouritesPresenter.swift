//
//  FavouritesPresenter.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

class FavouritesPresenter {

    weak var view: FavouritesViewController?

    required init(view: FavouritesViewController) {
        self.view = view
    }
    
    func getFavouritesDog() -> DogsModel.AllDogs {
        var dogs = DogsModel.AllDogs()
        let urlArray = [String]()
        let favouriteDogs = CoreDataStack.shared.fetchFavouritesDog()
        for dog in favouriteDogs {
            guard let name = dog.name else { continue }
            dogs["\(name)"] = urlArray
            print(dogs)
        }
        for dog in favouriteDogs {
            guard let name = dog.name, let url = dog.url else { continue }
            dogs["\(name)"]?.append(url)
            print(dogs)
        }
        
        return dogs
    }
}
