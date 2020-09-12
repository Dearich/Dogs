//
//  MainTableViewdataSource.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dogs = dogsModel else { return 0 }
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dogs = dogsModel else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainTableViewCell else {return UITableViewCell() }
        
        guard let breed = dogs[indexPath.row].breed?.capitalizingFirstLetter() else { return cell }
        guard let subbreeds = dogs[indexPath.row].relationship?.allObjects as? [Subbreed] else { return cell }
        if subbreeds.isEmpty {
            cell.textLabel?.text = breed
        } else {
            cell.textLabel?.text = "\(breed) (\(subbreeds.count) subbreeds)"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dogs = dogsModel else { return }
        if let subbreeds = dogs[indexPath.row].relationship?.allObjects as? [Subbreed], !subbreeds.isEmpty {
            let subbreedViewController =  ModuleBuilder.createSubBreedViewController()
            subbreedViewController.subbreeds = subbreeds.sorted(by: { (first, second) -> Bool in
                let bool = first.name! < second.name!
                return bool
            })
            navigationController?.pushViewController(subbreedViewController, animated: true)
        } else {
            guard let presenter = presenter as? MainPresenter, let breed = dogs[indexPath.row].breed else {print("Error"); return }
            presenter.getimageURls(breed: breed) {[weak self] (urlArray) in
                let imageViewController = ModuleBuilder.createImageViewController()
                
                var dogForSave = [DogForSaveModel]()
                for item in urlArray.message {
                    dogForSave.append(DogForSaveModel(name: breed, urls: item, like: false))
                }
                
                imageViewController.presenter.dogForSave = dogForSave
                self?.navigationController?.pushViewController(imageViewController, animated: true)
                
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
