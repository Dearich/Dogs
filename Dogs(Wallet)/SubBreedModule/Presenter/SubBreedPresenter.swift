//
//  SubBreedPresenter.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

class SubBreedPresenter: PresenterProtocol {
    weak var view: ViewProtocol?
    
    required init(view: ViewProtocol) {
        self.view = view
    }

}
