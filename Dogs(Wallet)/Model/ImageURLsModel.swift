//
//  ImageURLsModel.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation

struct ImageURLsModel: Decodable {
    let message: [String]
       
       private enum CodingKeys: String, CodingKey {
           case message
           
       }
       init(message:[String]) {
           self.message = message
       }
       
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           message = try container.decode([String].self, forKey: .message)
       }
}
