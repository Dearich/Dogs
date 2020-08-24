//
//  NetworkService.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 24.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import Alamofire

enum Request {
    
    case listAllBreeds
    case byBreed(breed: String)
    case bySubBreedImage(breed: String, subBreed: String)
    case bySubBreadList(breed: String)
    
}

class NetworkService {
    
    private let backgroundQueue = DispatchQueue(label: "azizbek.ru/backgroundTask",
                                                qos: .userInteractive, attributes: .concurrent)
    func getDogsInfo(with request: Request, completion: @escaping (DogsModel?, Error?) -> Void) {
        var urlString = ""
        switch request {
        case .listAllBreeds:
            urlString =  "https://dog.ceo/api/breeds/list/all?start=0&limit=10"
            
        case .byBreed(let breed):
            urlString =  "https://dog.ceo/api/breed/\(breed)/images"
            
        case .bySubBreadList(let breed):
            urlString =  "https://dog.ceo/api/breed/\(breed)/list"
            
        case .bySubBreedImage(let breed, let subBreed):
            urlString =  "https://dog.ceo/api/breed/\(breed)/\(subBreed)/images"
        }
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
}
