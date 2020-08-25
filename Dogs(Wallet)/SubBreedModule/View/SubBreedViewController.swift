//
//  SubBreedViewController.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class SubBreedViewController: UIViewController {
    var subbreeds: [Subbreed]?
    
    var presenter: SubBreedPresenter?

    let reuseIdentifier = "Cell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let title = subbreeds?[0].relationship?.breed?.capitalizingFirstLetter() else { return }
        self.navigationItem.title = title
    }
}

extension SubBreedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = subbreeds?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let subbreeds = subbreeds else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier,
                                                       for: indexPath) as UITableViewCell

        cell.textLabel?.text = subbreeds[indexPath.row].name?.capitalizingFirstLetter()
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let presenter = presenter,
            let subbreed = subbreeds?[indexPath.row].name,
            let breed = subbreeds?[indexPath.row].relationship?.breed
        else { return }
        presenter.getimageURls(breed: breed, subbreed: subbreed) {[weak self] (urlArray) in
            let imageViewController = ModuleBuilder.createImageViewController()
            var dogForSave = [DogForSaveModel]()
                           for item in urlArray.message {
                               dogForSave.append(DogForSaveModel(name: subbreed, urls: item, like: false))
                           }
            imageViewController.presenter.dogForSave = dogForSave
            self?.navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
}
