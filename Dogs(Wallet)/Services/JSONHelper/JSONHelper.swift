//
//  JSONHelper.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

class JSONHelper {
    static let shared = JSONHelper()
    
// MARK: - Parse to  Dogs Model
    func parseDogsInfo(with data: AFDataResponse<Any>,
                       completion: @escaping (DogsModel?, Error?) -> Void) {
        if data.error != nil {
            completion(nil, data.error)
        } else {
            do {
                guard let unwraptedData = data.data else { return }
                let decodedData = try JSONDecoder().decode(DogsModel?.self, from: unwraptedData)
                
                completion(decodedData, nil)
            } catch {
                print("decode error")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func parseDogsInfo2(with data: Data,
                        completion: @escaping (DogsModel?, Error?) -> Void) {
        do {
            let decodedData = try JSONDecoder().decode(DogsModel?.self, from: data)
            completion(decodedData, nil)
        } catch {
            
        }
    }
}
