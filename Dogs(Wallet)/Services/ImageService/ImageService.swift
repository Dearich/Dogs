//
//  ImageService.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit
class ImageService {
    static let cashe = NSCache<NSString, UIImage>()
    
    static func dowloadImage(withURL url: URL, complition: @escaping (_ image: UIImage?) -> Void ) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            var dowloadedImage:UIImage?
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            dowloadedImage = UIImage(data: data)
            
            if dowloadedImage != nil {
                //Cashing image
                cashe.setObject(dowloadedImage!, forKey: url.absoluteString as NSString)
            }
            DispatchQueue.main.async {
                complition(dowloadedImage)
            }
            
        }
        dataTask.resume()
    }
    
    static func getImageFromCashe(withURL url: URL, complition: @escaping (_ image: UIImage?) -> Void ) {
        if let image = cashe.object(forKey: url.absoluteString as NSString) {
            complition(image)
        } else {
            dowloadImage(withURL: url, complition: complition)
        }
    }
    
}
