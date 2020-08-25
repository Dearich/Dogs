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
        networkService.getDogsInfo {(dogsModel, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let dogs = dogsModel?.message else { return }
                DispatchQueue.main.async {
                    CoreDataStack.shared.saveAllDogs(lists: dogs)
                    UIView.animate(withDuration: 0.9) { [weak self] in
                        self?.view.alpha = 0
                        self?.spinner.stopAnimating()
                    }
                    UIApplication.shared.windows.first?.setRootViewController(Router(),
                                                                              options: UIWindow.TransitionOptions(direction: .fade,
                                                                                                                  style: .easeIn))
                }
            }
        }
    }
}
