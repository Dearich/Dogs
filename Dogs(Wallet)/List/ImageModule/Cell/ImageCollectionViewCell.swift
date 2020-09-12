//
//  ImageCollectionViewCell.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView.image != nil {
            spinner.stopAnimating()
            spinner.isHidden = true
        } else {
            spinner.isHidden = false
            spinner.startAnimating()
        }
        
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        
    }
}
