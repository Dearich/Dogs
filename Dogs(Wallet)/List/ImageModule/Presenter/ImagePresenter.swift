//
//  ImagePresenter.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import Foundation
import UIKit

class ImagePresenter {
    weak var view: ImageViewController?
    
    var dogForSave: [DogForSaveModel]?
    var imageToShare: UIImage?
    
    required init(view:ImageViewController) {
        self.view = view
    }
    
    func share() {
        let alert = UIAlertController(title: "Share photo", message: "", preferredStyle: .actionSheet)
        let alertActionShare = UIAlertAction(title: "Share", style: .default) { [weak self] (_) in
            guard let image = self?.imageToShare else { print("sharing is Failed"); return }
            
            // set up activity view controller
            let imageToShare = [ image ]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self?.view?.view // so that iPads won't crash
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            // present the view controller
            self?.view?.present(activityViewController, animated: true, completion: nil)
            
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { [weak self] (_) in
            self?.view?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertActionShare)
        alert.addAction(alertActionCancel)
        
        view?.present(alert,animated: true)
    }
    
    func getImage( url: URL, cellImage: UIImageView) {
        if CheckInternetConnection.connection() {
            ImageService.getImageFromCashe(withURL: url) { (image) in
                if image == nil {
                    DispatchQueue.main.async { [weak self] in
                        self?.setAlert(title:"Some server error" , message: "Try connect later", url: url, cellImage: cellImage )
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    cellImage.image = image
                    guard let image = image else { return }
                    self?.imageToShare = image
                }
            }
        } else {
            setAlert(title: "Lost connection", message: "Check your internet connection", url: url, cellImage: cellImage)
        }
    }

    func setAlert(title:String, message: String, url: URL, cellImage: UIImageView) {
        
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { (_) in
            self.getImage( url: url, cellImage: cellImage)
        }
        alert.addAction(action)
        view?.present(alert, animated: true)
        
    }
}
