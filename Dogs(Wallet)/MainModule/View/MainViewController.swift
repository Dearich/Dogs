//
//  MainViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, ViewProtocol {
    var presenter: PresenterProtocol?
    let spinner = SpinnerViewController()
    var dogsModel: DogsModel? {
        didSet {
            if let message = dogsModel?.message, !message.isEmpty {
                self.tableView.reloadData()
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dogsModel = DogsModel(message: [String:[String]]())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.register(MainTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
    }
}
