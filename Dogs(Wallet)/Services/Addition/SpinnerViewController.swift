//
//  SpinnerViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
    }
}

extension UIViewController {
    func createSpinner() -> SpinnerViewController {
        let spinner = SpinnerViewController()
        
        addChild(spinner)
        spinner.view.center.x = view.center.x
        spinner.view.center.y = view.center.y
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
        return spinner
    }
    func removeSpinner(spinner: SpinnerViewController ) {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}
