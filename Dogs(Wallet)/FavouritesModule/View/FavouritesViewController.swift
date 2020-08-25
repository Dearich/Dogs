//
//  FavouritesViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, ViewProtocol {
    var dogsModel: [Dog]?
    let spinner = SpinnerViewController()
    
    weak var presenter: PresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
