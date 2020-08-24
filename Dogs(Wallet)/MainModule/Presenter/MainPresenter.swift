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
    
    var dogsModel: DogsModel? {
        didSet {
            guard let dogsModel = dogsModel else { return }
                self.view?.dogsModel = dogsModel
        }
    }
    
    required init(view: ViewProtocol) {
        self.view = view

    }
}
