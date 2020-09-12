//
//  PresenterProtocol.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

protocol PresenterProtocol: class {
    init(view: ViewProtocol)
    func getAllDogs() -> [Dog]
}
extension PresenterProtocol {
    func getAllDogs() -> [Dog] {
        let dogs = CoreDataStack.shared.fetchLists()
        return dogs.sorted { (first, second) -> Bool in
            let bool = first.breed! < second.breed!
            return bool
        }
    }
}
