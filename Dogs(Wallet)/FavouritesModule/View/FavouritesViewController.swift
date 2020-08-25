//
//  FavouritesViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, ViewProtocol {
    let reuseIdentifier = "Cell"
    
    @IBOutlet weak var tableView: UITableView!
    var dogsModel: [Dog]?
    var favouriteDogs: [FavouritesDog]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var presenter: PresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteDogs = CoreDataStack.shared.fetchFavouritesDog()
    }
    
}
extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = favouriteDogs?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath) as UITableViewCell
        cell.textLabel?.text = favouriteDogs?[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //TODO
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
