//
//  StartViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        getDogs()
    }
    
    private func getDogs() {
        
        let networkService = NetworkService()
        networkService.getDogsInfo(with: .listAllBreeds) {(dogsModel, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let dogs = dogsModel?.message else { return }
                DispatchQueue.main.async {
                    CoreDataStack.shared.saveAllDogs(lists: dogs)
                }
            }
        }
    }
}
