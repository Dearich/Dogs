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
        guard let dogs = dogsModel?.message else { return 0 }
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dogs = dogsModel?.message else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MainTableViewCell else {return UITableViewCell() }
        
        let keyDog = Array(dogs.keys).sorted()
        
        let dogsListReadyToShow = keyDog[indexPath.row].capitalizingFirstLetter()
        guard let valueCount = dogs[keyDog[indexPath.row]] else { return UITableViewCell() }
        
        if valueCount.isEmpty {
            cell.textLabel?.text = dogsListReadyToShow
        } else {
            cell.textLabel?.text = "\(dogsListReadyToShow) (\(valueCount.count) subbreeds)"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
//    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dogs = dogsModel?.message else { return }
        let keyDog = Array(dogs.keys).sorted()
        if let valueCount = dogs[keyDog[indexPath.row]], !valueCount.isEmpty {
            guard let subbreedViewController = ModuleBuilder.createSubBreedScreen() as? SubBreedViewController else { return }
            subbreedViewController.dogsModel = DogsModel(message: [keyDog[indexPath.row]:valueCount])
            navigationController?.pushViewController(subbreedViewController, animated: true)
        } else {
            //GOTO Image
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
