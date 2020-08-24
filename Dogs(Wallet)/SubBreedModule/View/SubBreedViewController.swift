//
//  SubBreedViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class SubBreedViewController: UIViewController, ViewProtocol {
    
    var presenter: PresenterProtocol?
    let reuseIdentifier = "Cell"
    var dogsModel: DogsModel?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}
extension SubBreedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dogs = dogsModel?.message else { return 0 }
        let keyDog = Array(dogs.keys).sorted()
        guard let count = dogs[keyDog[0]]?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dogs = dogsModel?.message else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                       for: indexPath) as UITableViewCell
        let keyDog = Array(dogs.keys).sorted()
        guard let valueCount = dogs[keyDog[0]] else { return cell }
        
        cell.textLabel?.text = valueCount[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
