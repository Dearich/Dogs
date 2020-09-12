//
//  FavouritesViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    let reuseIdentifier = "Cell"
    
    @IBOutlet weak var tableView: UITableView!
    var dogsModel: [Dog]?
    var favouriteDogs: DogsModel.AllDogs? {
        didSet {
            tableView.reloadData()
        }
    }
    var dogs: [DogsModel]?
    
    var presenter: FavouritesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteDogs = presenter?.getFavouritesDog()
    }
    
}
extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = favouriteDogs?.count else { return 10 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                 for: indexPath) as UITableViewCell
        guard let keys = favouriteDogs?.keys else { return cell }
        let nameArray = Array(keys).sorted()
        guard let photoCount = favouriteDogs?[nameArray[indexPath.row]]?.count else { return cell }
        if photoCount == 1 {
            cell.textLabel?.text = "\(nameArray[indexPath.row].capitalizingFirstLetter()) (\(photoCount) photo)"
        } else {
            cell.textLabel?.text = "\(nameArray[indexPath.row].capitalizingFirstLetter()) (\(photoCount) photos)"
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let keys = favouriteDogs?.keys else { return }
        let nameArray = Array(keys).sorted()
        
        guard let urlArray = favouriteDogs?[nameArray[indexPath.row]] else { return }
        
        let imageViewController = ModuleBuilder.createImageViewController()
        
        var dogForSave = [DogForSaveModel]()
        for item in urlArray {
            dogForSave.append(DogForSaveModel(name: nameArray[indexPath.row], urls: item, like: true))
        }
        imageViewController.presenter.dogForSave = dogForSave
        navigationController?.pushViewController(imageViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
