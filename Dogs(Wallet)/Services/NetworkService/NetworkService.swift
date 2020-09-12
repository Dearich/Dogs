//
//  NetworkService.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

enum RequestImage {
    case byBreed(breed: String)
    case bySubBreedImage(breed: String, subBreed: String)
    
    var path: String {
        switch self {
        case .byBreed(let breed):
            return "https://dog.ceo/api/breed/\(breed)/images"
        case .bySubBreedImage(let breed, let subBreed):
            return "https://dog.ceo/api/breed/\(breed)/\(subBreed)/images"
        }
    }
}

class NetworkService {
    
    func getDogsInfo( completion: @escaping (DogsModel?, Error?) -> Void) {
        let urlString = "https://dog.ceo/api/breeds/list/all"
        AF.request(urlString).responseJSON(queue: .global()) { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            if let data = response.data {
                do {
                    let decodedData = try JSONDecoder().decode(DogsModel?.self, from: data)
                    
                    completion(decodedData, nil)
                } catch {
                    print("decode error")
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
    
    func getArrayOfURLs(request: RequestImage, completion: @escaping (ImageURLsModel?, Error?) -> Void) {
        
        AF.request(request.path).responseJSON(queue: .global()) { (response) in
            if let error = response.error {
                print(error.localizedDescription)
            }
            if let data = response.data {
                do {
                    let decodedData = try JSONDecoder().decode(ImageURLsModel?.self, from: data)
                    
                    completion(decodedData, nil)
                } catch {
                    print("decode error")
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }
    }
}
