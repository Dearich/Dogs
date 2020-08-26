//
//  SubBreedPresenter.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
class SubBreedPresenter {
    
    weak var view: SubBreedViewController?
    
    required init(view: SubBreedViewController) {
        self.view = view
    }
    
    func getimageURls(breed: String, subbreed: String, complition: @escaping ((ImageURLsModel) -> Void)) {
        let networkService = NetworkService()
        networkService.getArrayOfURLs(request: .bySubBreedImage(breed: breed, subBreed: subbreed)) { (urlArray, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let urlArray = urlArray {
                DispatchQueue.main.async {
                    complition(urlArray)
                }
            }
        }
    }
}
