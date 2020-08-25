//
//  ExImageViewControllerDataSource.swift
//  Dogs(Wallet)
//
//  Created by Азизбек on 25.08.2020.
//  Copyright © 2020 Azizbek Ismailov. All rights reserved.
//

import UIKit

extension ImageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = presenter.dogForSave?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                        for: indexPath) as? ImageCollectionViewCell
        else { return UICollectionViewCell() }
        
        guard let urlImageString  = presenter.dogForSave?[indexPath.row].urls else { return cell }
        guard let url = URL(string: urlImageString) else { return cell }
        presenter.getImage(spiner: spiner, url: url, cellImage: cell.imageView)
        return cell
    }
}
