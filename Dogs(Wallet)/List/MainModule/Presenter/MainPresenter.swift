//
//  MainPresenter.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

class MainPresenter:PresenterProtocol {
    
    weak var view: ViewProtocol?
    
    required init(view: ViewProtocol) {
        self.view = view
    }
    
    func getimageURls(breed: String, complition: @escaping ((ImageURLsModel) -> Void)) {
        let networkService = NetworkService()
        networkService.getArrayOfURLs(request: .byBreed(breed: breed)) { (urlArray, error) in
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
