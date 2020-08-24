//
//  ViewProtocol.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

protocol ViewProtocol: class {
    var presenter: PresenterProtocol? { get }
    var dogsModel: DogsModel? { get set }
}

extension ViewProtocol {
    var spinner: SpinnerViewController {
        return SpinnerViewController()
    }
}
