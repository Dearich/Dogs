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
        if CheckInternetConnection.connection() {
            getDogs()
        } else {
            setAlert(title: "Bad connection!", message: "Check your internet connection.")
        }
    }
    
    private func getDogs() {
        
        let networkService = NetworkService()
        networkService.getDogsInfo { [weak self] (dogsModel, error) in
            if let error = error {
                print(error.localizedDescription)
                self?.setAlert(title: "Some server error", message: "Try connect later")
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
    
    private func setAlert(title: String, message: String) {
        
        let alert = UIAlertController(title:title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) {[weak self] (_) in
            self?.getDogs()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
}
