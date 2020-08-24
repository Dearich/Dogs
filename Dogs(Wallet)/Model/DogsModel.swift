//
//  DogsModel.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

struct DogsModel: Decodable {
    typealias AllDogs = [String:[String]]
    let message: AllDogs
    
    private enum CodingKeys: String, CodingKey {
        case message
        
    }
    
    init(message:AllDogs) {
        self.message = message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(Dictionary.self, forKey: .message)
    }
}

struct DogsImagesURL: Codable {
    let message: [String]
    let status: String
}
